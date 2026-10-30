--- @sync entry
-- Incremental prefix navigation, match cycling, and smart-enter fallback for Yazi.

-- ya.render() isn't consistently bound across @sync contexts; fallback ensures
-- the status bar still repaints when the cursor stays parked on the same entry.
local function redraw()
	if ui and ui.render then
		ui.render()
	elseif ya and ya.render then
		ya.render()
	end
end

local function norm(str, case_sensitive)
	return case_sensitive and str or str:lower()
end

local function smart_enter()
	local h = cx.active.current and cx.active.current.hovered
	if h and h.cha.is_dir then
		ya.emit("enter", { hovered = true })
	elseif h and h:is_selected() then
		ya.emit("open", {})
	else
		ya.emit("open", { hovered = true })
	end
	ya.emit("escape", { find = true, filter = true })
end

-- Check the first byte before normalizing full strings to avoid GC churn in large directories.
local function scan_dir(files, start_cursor, search, case_sensitive, skip_current)
	local count = #files
	local len = #search
	local first = search:sub(1, 1)
	local start_offset = skip_current and 1 or 0

	for offset = start_offset, count - 1 do
		local idx = ((start_cursor + offset) % count) + 1
		local f = files[idx]

		if f and f.url and f.url.name then
			local raw = tostring(f.url.name)
			if norm(raw:sub(1, 1), case_sensitive) == first then
				if norm(raw, case_sensitive):sub(1, len) == search then
					return idx - 1
				end
			end
		end
	end
	return nil
end

return {
	setup = function(self, opts)
		opts = opts or {}
		self.timeout = opts.timeout or 1.5
		self.case_sensitive = opts.case_sensitive or false
		self.max_length = opts.max_length or 24

		self.buf = ""
		self.last_time = 0
		self.matched = true
		self.last_cwd = nil

		Status:children_add(function()
			if not self.buf or self.buf == "" then
				return ui.Line {}
			end

			if ya.time() - (self.last_time or 0) > self.timeout then
				self.buf = ""
				self.matched = true
				return ui.Line {}
			end

			local tag = self.matched and (" [find: " .. self.buf .. "] ") or (" [no match: " .. self.buf .. "] ")
			local color = self.matched and "yellow" or "red"
			return ui.Line { ui.Span(tag):fg(color):bold() }
		end, 1000, Status.LEFT)
	end,

	entry = function(self, job)
		if self.buf == nil then
			self.timeout = 1.5
			self.case_sensitive = false
			self.max_length = 24
			self.buf = ""
			self.last_time = 0
			self.matched = true
		end

		local key = job.args and job.args[1]
		if not key or key == "" then return end

		local now = ya.time()
		local folder = cx.active.current
		local cwd = folder and folder.cwd and tostring(folder.cwd)

		if cwd ~= self.last_cwd or (now - self.last_time > self.timeout) then
			self.buf = ""
			self.matched = true
			self.last_cwd = cwd
		end
		self.last_time = now

		-- Clear state before emitting escape so we don't race Yazi's native teardown.
		if key == "escape" or key == "<Esc>" or key == "cancel" then
			self.buf = ""
			self.matched = true
			ya.emit("escape", { all = true })
			redraw()
			return
		end

		if key == "right" or key == "<Right>" or key == "open" then
			self.buf = ""
			self.matched = true
			redraw()
			smart_enter()
			return
		end

		if not folder or not folder.files or #folder.files == 0 then
			redraw()
			return
		end

		local files = folder.files
		local cursor = folder.cursor

		if key == "enter" or key == "<Enter>" or key == "next" then
			if self.buf == "" or not self.matched then
				self.buf = ""
				self.matched = true
				redraw()
				smart_enter()
				return
			end

			local search = norm(self.buf, self.case_sensitive)
			local next_idx = scan_dir(files, cursor, search, self.case_sensitive, true)

			if next_idx then
				ya.emit("arrow", { next_idx - cursor })
				redraw()
			else
				self.buf = ""
				self.matched = true
				redraw()
				smart_enter()
			end
			return
		end

		local char = norm(key, self.case_sensitive)
		local next_buf = self.buf .. char

		if #next_buf > self.max_length then
			next_buf = next_buf:sub(#next_buf - self.max_length + 1)
		end
		self.buf = next_buf

		if not self.matched then
			redraw()
			return
		end

		local search = norm(self.buf, self.case_sensitive)
		local match_idx = scan_dir(files, cursor, search, self.case_sensitive, false)

		if match_idx then
			self.matched = true
			if match_idx ~= cursor then
				ya.emit("arrow", { match_idx - cursor })
			end
		else
			self.matched = false
		end

		redraw()
	end,
}
