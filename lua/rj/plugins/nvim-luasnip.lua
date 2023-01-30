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
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

void solve(){{
	{}
}};

int main(){{
    int t;
    scanf("%i", &t);
    while(t--){{
        solve();
    }}
    return 0;
}}
]],
			{
				i(1, "// solution"),
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
				i(1, "// solution"),
			}
		)
	),
})
