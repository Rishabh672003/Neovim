local M = {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
}

function M.config()
  local ls = require("luasnip")
  local s = ls.snippet
  local i = ls.insert_node
  local fmt = require("luasnip.extras.fmt").fmt

  ls.config.set_config({
    history = true, --keep around last snippet local to jump back
    updateevents = "TextChanged,TextChangedI", --update changes as you type
    enable_autosnippets = true,
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
#include <bits/stdc++.h>
using namespace std;

#define ll long long
#define ld long double
#define str string

void solve() {{
    int x, y;
    cin >> x >> y;
	{}
}}

int main() {{
    ios::sync_with_stdio(0);
    cin.tie(0);
    ll t;
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
      "ccc",
      fmt(
        [[
#include <bits/stdc++.h>
using namespace std;

#define ll long long
#define ld long double
#define str string

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

using std::cout, std::cin, std::endl, std::string;

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
