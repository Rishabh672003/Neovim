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
		"c",
		fmt(
			[[
#include <iostream>
#include <string.h>
#include <vector>
#include <math.h>

using namespace std;

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

ls.add_snippets("java", {
	s(
		"cc",
		fmt(
			[[
import java.util.*;

class Test {{
    public static void main(String args[]){{
        Scanner sc = new Scanner(System.in);
		{}
    }}
}}
]],
			{
				i(1),
			}
		)
	),
})
