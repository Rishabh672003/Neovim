local M = {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
}

function M.config()
  vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = function()
      if
        ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
        and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })
  local ls = require("luasnip")
  local s = ls.snippet
  local i = ls.insert_node
  local fmt = require("luasnip.extras.fmt").fmt

  require("luasnip").filetype_extend("javascriptreact", { "html" })
  require("luasnip").filetype_extend("typescriptreact", { "html" })

  ls.config.set_config({
    history = true, --keep around last snippet local to jump back
    updateevents = "TextChanged,TextChangedI", --update changes as you type
    enable_autosnippets = true,
  })

  ls.add_snippets("python", {
    s(
      "cc",
      fmt(
        [[
class Solution:
    {}


if __name__ == "__main__":
    {}
    sol = Solution()
    print(sol.{})
        ]],

        {
          i(1),
          i(2),
          i(3),
        }
      )
    ),
  })

  ls.add_snippets("c", {

    s(
      "cc",
      fmt(
        [[
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void solve() {{
    int x, y;
    scanf("%i%i", &x, &y);
	{}
}};

int main() {{
    int t;
    scanf("%i", &t);
    while (t--) {{
        solve();
    }}
    return 0;
}}
]],
        {
          i(1),
        }
      )
    ),
  })

  ls.add_snippets("c", {
    s(
      "c",
      fmt(
        [[
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {{
	{}
    return 0;
}}
]],
        {
          i(1),
        }
      )
    ),
  })

  ls.add_snippets("cpp", {
    s(
      "cc",
      fmt(
        [[
#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <numeric>

using std::ios, std::cout, std::cin, std::endl, std::string, std::vector;

void solve() {{
    int x, y;
    cin >> x >> y;
	{}
}}

int main() {{
    ios::sync_with_stdio(0);
    cin.tie(0);
    long long t;
    cin >> t;
    while (t--)
        solve();
    return 0;
}}
]],
        {
          i(1),
        }
      )
    ),
  })

  ls.add_snippets("cpp", {
    s(
      "aoc",
      fmt(
        [[
#include <fstream>
#include <functional>
#include <iostream>
#include <string>

using std::cout, std::cin, std::string;

int main() {{
    std::ifstream myfile("input.txt");

    if (!myfile) {{
        std::cerr << "Input file cannot be opened for reading.\n";

        return 1;
    }}

    while (myfile) {{
        string line;
        myfile >> line;
        if (line.empty()) {{
            break;
        }}
        {}
    }}
    myfile.close();
    return 0;
}}
]],
        {
          i(1),
        }
      )
    ),
  })

  ls.add_snippets("cpp", {
    s(
      "ccc",
      fmt(
        [[
#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <numeric>

using std::ios, std::cout, std::cin, std::endl, std::string, std::vector;

class Solution {{
    {}
}};

int main() {{
    Solution sol;
    {}
    return 0;
}}
]],
        {
          i(1),
          i(2),
        }
      )
    ),
  })

  ls.add_snippets("cpp", {
    s(
      "c",
      fmt(
        [[
#include <iostream>
#include <string>

using std::cout, std::cin, std::string;

int main() {{
	{}

	return 0;
}}
]],
        {
          i(1),
        }
      )
    ),
  })

  ls.add_snippets("rust", {
    s(
      "cc",
      fmt(
        [[
use std::io;

fn solution() {{
    let mut input_nums = String::new();
    io::stdin().read_line(&mut input_nums).expect("failed to read line");
    let mut iter= input_nums.split_whitespace();
    let x: i32 = iter.next().unwrap().parse().expect("input not an integer");
    let y: i32 = iter.next().unwrap().parse().expect("input not an integer");
	{}
}}

fn main() {{
    let mut t = String::new();
    io::stdin().read_line(&mut t).expect("Failed to read line");
    let mut t: i32 = t.trim().parse().expect("Input not an integer");
    while t > 0 {{
        solution();
        t -= 1;
    }}
}}
			]],
        {
          i(1),
        }
      )
    ),
  })
end

return M
