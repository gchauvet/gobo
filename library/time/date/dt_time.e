indexing

	description:

		"Times"

	note:       "Do not take leap seconds into account"
	library:    "Gobo Eiffel Time Library"
	author:     "Eric Bezault <ericb@gobosoft.com>"
	copyright:  "Copyright (c) 2000, Eric Bezault and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

class DT_TIME

inherit

	DT_ABSOLUTE_TIME
		undefine
			out
		end

	DT_TIME_VALUE
		redefine
			append_time_to_string, append_precise_time_to_string
		end

	DT_GREGORIAN_CALENDAR
		undefine
			out
		end

creation

	make, make_precise,
	make_from_second_count,
	make_from_millisecond_count

creation {DT_DATE_TIME}

	make_from_storage

feature {NONE} -- Initialization

	make (h, m, s: INTEGER) is
			-- Create a new time.
		require
			h_large_enough: h >= 0
			h_small_enough: h < Hours_in_day
			m_large_enough: m >= 0
			m_small_enough: m < Minutes_in_hour
			s_large_enough: s >= 0
			s_small_enough: s < Seconds_in_minute
		do
			storage := h * Hour_shift + m * Minute_shift + s * Second_shift
		ensure
			hour_set: hour = h
			minute_set: minute = m
			second_set: second = s
			millisecond_set: millisecond = 0
		end

	make_precise (h, m, s, ms: INTEGER) is
			-- Create a new time with millisecond precision.
		require
			h_large_enough: h >= 0
			h_small_enough: h < Hours_in_day
			m_large_enough: m >= 0
			m_small_enough: m < Minutes_in_hour
			s_large_enough: s >= 0
			s_small_enough: s < Seconds_in_minute
			ms_large_enough: ms >= 0
			ms_small_enough: ms < 1000
		do
			storage := h * Hour_shift + m * Minute_shift + s * Second_shift + ms
		ensure
			hour_set: hour = h
			minute_set: minute = m
			second_set: second = s
			millisecond_set: millisecond = ms
		end

	make_from_second_count (s: INTEGER) is
			-- Create a new time from the number
			-- seconds since midnight.
		require
			s_large_enough: s >= 0
			s_small_enough: s < Seconds_in_day
		do
			set_second_count (s)
		ensure
			second_count_set: second_count = s
		end

	make_from_millisecond_count (ms: INTEGER) is
			-- Create a new time from the number
			-- milliseconds since midnight.
		require
			ms_large_enough: ms >= 0
			ms_small_enough: ms < Milliseconds_in_day
		do
			set_millisecond_count (ms)
		ensure
			millisecond_count_set: millisecond_count = ms
		end

	make_from_storage (a_storage: INTEGER) is
			-- Create a new time from `a_storage'.
		do
			storage := a_storage
		ensure
			storage_set: storage = a_storage
		end

feature -- Access

	hour: INTEGER is
			-- Hour
		do
			Result := storage // Hour_shift
		ensure then
			hour_large_enough: hour >= 0
			hour_small_enough: hour < Hours_in_day
		end

	minute: INTEGER is
			-- Minute
		do
			Result := (storage // Minute_shift) \\ 60
		ensure then
			minute_large_enough: minute >= 0
			minute_small_enough: minute < Minutes_in_hour
		end

	second: INTEGER is
			-- Second
		do
			Result := (storage // Second_shift) \\ 60
		ensure then
			second_large_enough: second >= 0
			second_small_enough: second < Seconds_in_minute
		end

	millisecond: INTEGER is
			-- Millisecond
		do
			Result := storage \\ 1000
		ensure then
			millisecond_large_enough: millisecond >= 0
			millisecond_small_enough: millisecond < 1000
		end

	second_count: INTEGER is
			-- Number of seconds since midnight
		do
			Result := storage // 1000
		ensure
			definition: Result = (((hour * Minutes_in_hour) + minute) *
				Seconds_in_minute + second)
		end

	millisecond_count: INTEGER is
			-- Number of milliseconds since midnight
		do
			Result := storage
		ensure
			definition: Result = ((((hour * Minutes_in_hour) + minute) *
				Seconds_in_minute + second) * 1000 + millisecond)
		end

	duration (other: like Current): DT_TIME_DURATION is
			-- Duration between `other' and current time
		do
			Result := time_duration (other)
		end

	canonical_duration (other: like Current): like duration is
			-- Canonical duration between `other' and current time
		require
			other_not_void: other /= Void
		do
			!! Result.make_precise_canonical (millisecond_count - other.millisecond_count)
		ensure
			duration_not_void: Result /= Void
				-- The following assertion has been commented out
				-- because of a bug in SmallEiffel -0.76b1 (implicit
				-- feature renaming in DT_DATE_TIME).
--			canonical_duration: Result.is_canonical
			definition: (other + Result).is_equal (Current)
		end

	time_duration (other: like Current): DT_TIME_DURATION is
			-- Duration between `other' and current time
		require
			other_not_void: other /= Void
		do
			!! Result.make_precise (hour - other.hour, minute - other.minute,
				second - other.second, millisecond - other.millisecond)
		ensure
			time_duration_not_void: Result /= Void
			definition: (other &t Result).is_equal (Current)
		end

	infix "&t" (a_duration: like time_duration): like Current is
			-- Addition of `a_duration' to current time
			-- (Create a new object at each call.)
		require
			a_duration_not_void: a_duration /= Void
		do
			Result := clone (Current)
			Result.add_time_duration (a_duration)
		ensure
			addition_not_void: Result /= Void
		end

	hash_code: INTEGER is
			-- Hash code
		do
			Result := storage
		end

feature -- Setting

	set_hour_minute_second (h, m, s: INTEGER) is
			-- Set `hour' to `h', `minute' to `m' and `second' to `s'.
		require
			h_large_enough: h >= 0
			h_small_enough: h < Hours_in_day
			m_large_enough: m >= 0
			m_small_enough: m < Minutes_in_hour
			s_large_enough: s >= 0
			s_small_enough: s < Seconds_in_minute
		do
			storage := h * Hour_shift + m * Minute_shift + s * Second_shift
		ensure
			hour_set: hour = h
			minute_set: minute = m
			second_set: second = s
			millisecond_set: millisecond = 0
		end

	set_precise_hour_minute_second (h, m, s, ms: INTEGER) is
			-- Set `hour' to `h', `minute' to `m', `second'
			-- to `s', and `millisecond' to `ms'.
		require
			h_large_enough: h >= 0
			h_small_enough: h < Hours_in_day
			m_large_enough: m >= 0
			m_small_enough: m < Minutes_in_hour
			s_large_enough: s >= 0
			s_small_enough: s < Seconds_in_minute
			ms_large_enough: ms >= 0
			ms_small_enough: ms < 1000
		do
			storage := h * Hour_shift + m * Minute_shift + s * Second_shift + ms
		ensure
			hour_set: hour = h
			minute_set: minute = m
			second_set: second = s
			millisecond_set: millisecond = ms
		end

	set_hour (h: INTEGER) is
			-- Set `hour' to `h'.
		require
			h_large_enough: h >= 0
			h_small_enough: h < Hours_in_day
		do
			storage := h * Hour_shift + storage \\ Hour_shift
		ensure
			hour_set: hour = h
			same_minute: minute = old minute
			same_second: second = old second
			same_millisecond: millisecond = old millisecond
		end

	set_minute (m: INTEGER) is
			-- Set `minute' to `m'.
		require
			m_large_enough: m >= 0
			m_small_enough: m < Minutes_in_hour
		do
			storage := (storage // Hour_shift) * Hour_shift +
				m * Minute_shift + storage \\ Minute_shift
		ensure
			minute_set: minute = m
			same_hour: hour = old hour
			same_second: second = old second
			same_millisecond: millisecond = old millisecond
		end

	set_second (s: INTEGER) is
			-- Set `second' to `s'.
		require
			s_large_enough: s >= 0
			s_small_enough: s < Seconds_in_minute
		do
			storage := (storage // Minute_shift) * Minute_shift +
				s * Second_shift + storage \\ Second_shift
		ensure
			second_set: second = s
			same_hour: hour = old hour
			same_minute: minute = old minute
			same_millisecond: millisecond = old millisecond
		end

	set_millisecond (ms: INTEGER) is
			-- Set `millisecond' to `ms'.
		require
			ms_large_enough: ms >= 0
			ms_small_enough: ms < 1000
		do
			storage := (storage // Second_shift) * Second_shift + ms
		ensure
			millisecond_set: millisecond = ms
			same_hour: hour = old hour
			same_minute: minute = old minute
			same_second: second = old second
		end

	set_second_count (s: INTEGER) is
			-- Set `second_count' to `s'.
		require
			s_large_enough: s >= 0
			s_small_enough: s < Seconds_in_day
		do
			storage := s * 1000
		ensure
			second_count_set: second_count = s
		end

	set_millisecond_count (ms: INTEGER) is
			-- Set `millisecond_count' to `ms'.
		require
			ms_large_enough: ms >= 0
			ms_small_enough: ms < Milliseconds_in_day
		do
			storage := ms
		ensure
			millisecond_count_set: millisecond_count = ms
		end

feature -- Element change

	add_duration (a_duration: like duration) is
			-- Add `a_duration' to current time.
		do
			add_time_duration (a_duration)
		end

	add_time_duration (a_duration: like time_duration) is
			-- Add `a_duration' to current time.
		require
			a_duration_not_void: a_duration /= Void
		do
			add_milliseconds (a_duration.millisecond_count)
		end

	add_hours_minutes_seconds (h, m, s: INTEGER) is
			-- Add `h' hours, `m' minutes and
			-- `s' seconds to current time.
		do
			add_seconds ((h * Minutes_in_hour + m) * Seconds_in_minute + s)
		end

	add_precise_hours_minutes_seconds (h, m, s, ms: INTEGER) is
			-- Add `h' hours, `m' minutes, `s' seconds
			-- and `ms' milliseconds to current time.
		do
			add_milliseconds (((h * Minutes_in_hour + m) * Seconds_in_minute + s) * 1000 + ms)
		end

	add_hours (h: INTEGER) is
			-- Add `h' hours to current time.
		do
			if h /= Void then
				storage := storage + h * Hour_shift
				if storage < 0 then
					storage := Day_shift - ((-storage) \\ Day_shift)
				else
					storage := storage \\ Day_shift
				end
			end
		end

	add_minutes (m: INTEGER) is
			-- Add `m' minutes to current time.
		do
			if m /= 0 then
				storage := storage + m * Minute_shift
				if storage < 0 then
					storage := Day_shift - ((-storage) \\ Day_shift)
				else
					storage := storage \\ Day_shift
				end
			end
		end

	add_seconds (s: INTEGER) is
			-- Add `s' seconds to current time.
		do
			if s /= Void then
				storage := storage + s * Second_shift
				if storage < 0 then
					storage := Day_shift - ((-storage) \\ Day_shift)
				else
					storage := storage \\ Day_shift
				end
			end
		end

	add_milliseconds (ms: INTEGER) is
			-- Add `ms' milliseconds to current time.
		do
			if ms /= 0 then
				storage := storage + ms
				if storage < 0 then
					storage := Day_shift - ((-storage) \\ Day_shift)
				else
					storage := storage \\ Day_shift
				end
			end
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current time before `other' on the time axis?
		do
			Result := storage < other.storage
		end

feature -- Output

	append_time_to_string (a_string: STRING) is
			-- Append printable representation
			-- (hh:mm:ss[.sss]) to `a_string'.
			-- (The millisecond part appears only when not zero.)
		local
			h, m, s, ms: INTEGER
		do
			h := hour
			if h < 10 then
				a_string.append_character ('0')
			end
			INTEGER_FORMATTER_.append_decimal_integer (a_string, h)
			a_string.append_character (':')
			m := minute
			if m < 10 then
				a_string.append_character ('0')
			end
			INTEGER_FORMATTER_.append_decimal_integer (a_string, m)
			a_string.append_character (':')
			s := second
			if s < 10 then
				a_string.append_character ('0')
			end
			INTEGER_FORMATTER_.append_decimal_integer (a_string, s)
			ms := millisecond
			if ms /= 0 then
				a_string.append_character ('.')
				if ms < 10 then
					a_string.append_character ('0')
					a_string.append_character ('0')
				elseif ms < 100 then
					a_string.append_character ('0')
				end
				INTEGER_FORMATTER_.append_decimal_integer (a_string, ms)
			end
		end

	append_precise_time_to_string (a_string: STRING) is
			-- Append printable representation (hh:mm:ss.sss)
			-- to `a_string'.
		local
			ms: INTEGER
		do
			append_time_to_string (a_string)
			if millisecond = 0 then
				a_string.append_character ('.')
				a_string.append_character ('0')
				a_string.append_character ('0')
				a_string.append_character ('0')
			end
		end

feature {DT_TIME} -- Implementation

	storage: INTEGER
			-- Compact version of current time
			-- (INTEGER should have at least 32 bits.)

feature {NONE} -- Constants

	Day_shift: INTEGER is 86400000  -- 1d = 24*60*60*1000ms
	Hour_shift: INTEGER is 3600000  -- 1h = 60*60*1000ms
	Minute_shift: INTEGER is 60000  -- 1m = 60*1000ms
	Second_shift: INTEGER is 1000   -- 1s = 1000ms

invariant

	storage_positive: storage >= 0
	storage_small_enough: storage < Milliseconds_in_day

end -- class DT_TIME
