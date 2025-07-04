-- local dbg = require("debugger")
-- dbg.auto_where = 2

local append = require'lamine.tools.table'.append
local C = require'lamine.autocompletion.completers'
local P = require'lamine.autocompletion.patterns'

local do_completion_kwds = {
  case = 'case',
  def = 'def',
  defp = 'defp',
}

local do_completions = {
  -- catch already there
  {
    "^(%s*)(.*)(%sdo)(%s*)",
    C.replace_matches_and_add_lines{
      replacers={nil, nil, nil, ''},
      lines={"  ", "end"},
      offset={1, 999}
    }
  },
  {
    "^(%s*)(%w+)(.*)(%s*)",
    C.replace_matches_and_add_lines{
      replacers={nil, C.match_against_table(do_completion_kwds), nil, ' do'},
      lines={"  ", "end"},
      offset={1, 999}
    }
  },
}

local multiline_string_attribute_names = {
  doc = "@doc",
  moduledoc = "@moduledoc",
}
local multiline_string_completions = {
  {
    "(%s*)(%@?)(%w+)(%s*)$",
    C.replace_matches_and_add_lines{
      replacers={nil, '', C.match_against_table(multiline_string_attribute_names), ' ~S"""'},
      lines={"",'"""'},
      offset={1, 999}
    }
  },
  {
    "(%s*)(@?doc)(%s*)$",
    C.replace_matches_and_add_lines{
      replacers={nil, '@doc',' """'},
      lines={"  ",'"""'},
      offset={1, 999}
    }
  }, 
}
local inline_completions = {
  {
    "^(%s*)(<<.*)(%s*)$",
    C.replace_matches_and_add_lines{
      replacers = {
        nil, nil, ">> -> "
      },
      lines={}, offset = {0, 6}, continue={0, 999}}
  },
  {
    "^(.*)(%%M)(%s*)$",
    C.replace_matches_and_add_lines{
      replacers = {
        nil, "%__MODULE__{}", ''
      },
      lines={}, offset = {0, 10}, continue={0, 999}}
  },
  {
    "^(.*)(MOD)(%s*)$",
    C.replace_matches_and_add_lines{
      replacers = {
        nil, nil, "__MODULE__"
      },
      lines={}, offset = {0, 6}, continue={0, 999}}
  },
  {
    "^(.*)(%%)(%s*)$",
    C.replace_matches_and_add_lines{
      replacers = {
        nil, nil, "{}"
      },
      lines={}, offset = {0, 1}, continue={0, 999}}
  },
  {
    "^(.*)(%%)(%w+)(.*)$",
    C.replace_matches_and_add_lines{
      replacers = {
        nil, "%", nil, "{}"
      },
      lines={}, offset = {0, -1}, continue={0, 999}}
  },
  {
    "^(%s*)(.*)(@@@)",
    C.replace_suffix_and_add_lines{lines={}, suffix="#{}", offset={0, -1}, continue={0, 999}}
  },
  {
    "^(%s*)(.*)(IO%.inspect)",
    C.replace_suffix_and_add_lines{lines={}, suffix="IO.inspect(%%{})", offset={0, 3}, continue={0, 999}}
  },
  {
    "^(%s*)(.*)(%|%s*)$",
    C.replace_suffix_and_add_lines{lines={}, suffix="|> ", offset={0, 999}}
  },
  {
    "^(%s*)(.*)(www)",
    C.replace_suffix_and_add_lines{lines={}, suffix="~W[]", offset={0, 0}, continue={0, 999}}
  },
  {
    "^(%s*)(.*)(fn)",
    C.replace_suffix_and_add_lines{lines={}, suffix="fn -> ", offset={0, 999}}
  },
  {
    "^(%s*)(.*)(%sOK)",
    C.replace_suffix_and_add_lines{lines={}, suffix=" {:ok, ", offset={0, 999}}
  },
  {
    "^(%s*)(.*)(%sNOK)",
    C.replace_suffix_and_add_lines{lines={}, suffix=" {:error,", offset={0, 999}}
  },
  {
    "^(%s*)(.*)(%sdefkwd)",
    C.replace_suffix_and_add_lines{lines={}, suffix=" \\\\ [])", offset={0, 999}}
  },
}

local next_line_completions = {
  {
    "^(%s*)(.*)(%S)(%s+)$",
    C.replace_matches_and_add_lines{
      replacers={nil, nil, nil, ''},
      lines={"|> "},
      offset={1, 999}
    },
  },
  {
    "(%s*)(%|%>)(.*)(%s*)$",
    C.replace_matches_and_add_lines{
      replacers={nil, nil, nil, ''},
      lines={"|> "},
      offset={1, 999}
    },
  },
  {
    "^(%s*)(.*)(optopt)(%s*)$",
    C.replace_matches_and_add_lines{
      replacers={nil, nil, 'options \\\\ []) do', ''},
      lines={"  ", "end"},
      offset={1, 999}
    },
  },
}

-- local match_completions = {
--   {
--     "^(%s*)(.*)(%s%%)([wW])(%s*)$",
--     C.replace_matches{
--       nil, nil, '', C.match_elements(" [", 4, "] ", {offset={0, -1}})}
--   },
-- }

local completions =
  append(
    inline_completions,
    next_line_completions,
    multiline_string_completions,
    do_completions
    -- match_completions
  )

-- vim.print(completions)
return completions

-- SPDX-License-Identifier: AGPL-3.0-or-later
