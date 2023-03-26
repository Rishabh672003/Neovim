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
#include <algorithm>

using namespace std;

int main() {{
	{}
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
import java.io.*;
import java.util.*;

public class Test {{
  static PrintWriter out=new PrintWriter((System.out));
  static Reader sc=new Reader();
  public static void main(String args[])throws IOException {{
    int t=sc.nextInt();
    while(t-->0) {{
      solve();
    }}
      out.close();
  }}

  public static void solve() {{
		{}
  }}
    
  static class Reader {{ 
    BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
    StringTokenizer st = new StringTokenizer("");
    public String next() {{
      while(!st.hasMoreTokens()) {{
        try {{
          st = new StringTokenizer(br.readLine());
        }} catch(Exception e) {{
          e.printStackTrace();
        }}
      }}
      return st.nextToken();
    }}
    public int nextInt() {{
      return Integer.parseInt(next());
    }}
    public long nextLong() {{
      return Long.parseLong(next());
    }}
    public double nextDouble() {{
      return Double.parseDouble(next());
    }}
    public String nextLine() {{
      try {{
        return br.readLine();
      }} catch(Exception e) {{
        e.printStackTrace();
      }}
      return null;
    }}
    public boolean hasNext() {{
      String next = null;
      try {{
        next = br.readLine();
      }} catch(Exception e) {{}}
      if(next == null) {{
        return false;
      }}
      st = new StringTokenizer(next);
      return true;
    }}
  }}
}}
]],
			{
				i(1),
			}
		)
	),
})
