local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local ms = ls.multi_snippet
-- local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local r = require('luasnip.extras').rep
local l = require('luasnip.extras').lambda
local pf = require('luasnip.extras.postfix').postfix
local a = require('luasnip.util.extend_decorator').apply(s, {
  snippetType = 'autosnippet',
})

local make_condition = require('luasnip.extras.conditions').make_condition

local line_begin = require('luasnip.extras.expand_conditions').line_begin

local math = make_condition(function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end)

local get_visual = function(_, parent)
  -- If LS_SELECT_RAW is empty, return a blank insert node
  if #parent.snippet.env.LS_SELECT_RAW == 0 then
    return sn(nil, i(1))
  else
    return sn(nil, t(parent.snippet.env.LS_SELECT_RAW))
  end
end

local latin_to_greek = {
  a = 'alpha',
  b = 'beta',
  g = 'gamma',
  d = 'delta',
  e = 'varepsilon',
  z = 'zeta',
  n = 'eta',
  h = 'theta',
  i = 'iota',
  k = 'kappa',
  l = 'lambda',
  m = 'mu',
  v = 'nu',
  x = 'xi',
  p = 'pi',
  r = 'rho',
  s = 'sigma',
  t = 'tau',
  u = 'upsilon',
  f = 'varphi',
  c = 'chi',
  y = 'psi',
  w = 'omega',
  o = 'omega',
}

local greek_with_vars = {
  'epsilon',
  'theta',
  'kappa',
  'pi',
  'rho',
  'sigma',
  'phi',
}

local snippets = {}
-- allows swapping between greek letters and their variants
-- example: \phiv -> \varphi and \varphiv -> \phi
for _, greek in ipairs(greek_with_vars) do
  local var = '\\var' .. greek
  greek = '\\' .. greek
  vim.list_extend(snippets, {
    a({ trig = greek .. 'v', wordTrig = false }, t(var), { condition = math }),
    a({ trig = var .. 'v', wordTrig = false }, t(greek), { condition = math }),
  })
end

return vim.list_extend(snippets, {
  -- greek letter snippets, autotriggered for efficiency
  a({ trig = '%f[%w;];([%a])', wordTrig = false, regTrig = true }, {
    t '\\',
    f(function(_, snip)
      local greek = latin_to_greek[snip.captures[1]:lower()]
      if snip.captures[1]:match '%u' then
        return greek:gsub('^%l', string.upper)
      else
        return greek
      end
    end),
  }),

  -- postfixes
  -- I'd like to have some way of being able to wrap things in parentheses and apply postfix to the inside
  pf(
    { trig = '.h', match_pattern = [[[\\%w%.%_%-%"%'%+%{%}]+$]], snippetType = 'autosnippet' },
    { l('\\hat{' .. l.POSTFIX_MATCH .. '}') },
    { condition = math }
  ),
  a('.h', fmta('\\hat{<>}', { d(1, get_visual) }), { condition = math }),
  pf({ trig = '.v', match_pattern = [[[\\%w%.%_%-%"%'%+%{%}]+$]], snippetType = 'autosnippet' }, {
    f(function(_, snip)
      local match = snip.env.POSTFIX_MATCH
      if match:sub(1, 1) == '\\' or #match == 1 then
        return '\\vec{' .. match .. '}'
      else
        return '\\overrightarrow{' .. match .. '}'
      end
    end),
  }, { condition = math }),
  a('.v', fmta('\\vec{<>}', { d(1, get_visual) }), { condition = math }),
  pf(
    { trig = '.b', match_pattern = [[[\\%w%.%_%-%"%'%+%{%}]+$]], snippetType = 'autosnippet' },
    { l('\\overline{' .. l.POSTFIX_MATCH .. '}') },
    { condition = math }
  ),
  a('.b', fmta('\\overline{<>}', { d(1, get_visual) }), { condition = math }),
  pf(
    { trig = '.d', match_pattern = [[[\\%w%.%_%-%"%'%+%{%}]+$]], snippetType = 'autosnippet' },
    { l('\\dot{' .. l.POSTFIX_MATCH .. '}') },
    { condition = math }
  ),
  a('.d', fmta('\\dot{<>}', { d(1, get_visual) }), { condition = math }),
  pf(
    { trig = '.D', match_pattern = [[[\\%w%.%_%-%"%'%+%{%}]+$]], snippetType = 'autosnippet' },
    { l('\\ddot{' .. l.POSTFIX_MATCH .. '}') },
    { condition = math }
  ),
  a('.D', fmta('\\ddot{<>}', { d(1, get_visual) }), { condition = math }),

  -- commonly repeated abstractions
  -- s('g*', t '$(G, \\ast)$'),
  -- s('sn', t '$(S_n, \\circ)$'),

  -- various mathematical symbols and the like
  a('mm', fmta('$<>$', { i(1) }), { condition = -math }),
  a('ff', fmta('\\frac{<>}{<>}', { i(1), i(2) }), { condition = math }),
  a({ trig = 'nv', wordTrig = false }, t '^{-1}', { condition = math }),
  a('ra', t '\\rightarrow', { condition = math }),
  a('Ra', t '\\Rightarrow', { condition = math }),
  a('ua', t '\\uparrow', { condition = math }),
  a('da', t '\\downarrow', { condition = math }),
  a('\\text{ if }f', t '\\Leftrightarrow', { condition = math }),
  a('in', t '\\in', { condition = math }),
  a('ni', t '\\not\\in', { condition = math }),
  a('le', t '\\le', { condition = math }),
  a('ge', t '\\ge', { condition = math }),
  a('ne', t '\\ne', { condition = math }),
  a('dv', t '\\mid', { condition = math }),
  a('nd', t '\\nmid', { condition = math }),
  a('as', t '\\ast', { condition = math }),
  a('dm', t '\\diamond', { condition = math }),
  a('lz', t '\\lozenge', { condition = math }),
  a('sq', t '\\square', { condition = math }),
  a('tr', t '\\triangle', { condition = math }),
  a('rc', t '\\circ', { condition = math }),
  a('dt', t '\\cdot', { condition = math }),
  a('od', t '\\odot', { condition = math }),
  a('tm', t '\\times', { condition = math }),
  a('vd', t '\\vdash', { condition = math }),
  a('qqd', t '\\qquad', { condition = math }),
  a('qd', t '\\quad', { condition = math }),
  a({ trig = '%f[%w]ll', wordTrig = false, regTrig = true }, t '\\ell', { condition = math }),
  a('es', t '\\emptyset', { condition = math }),
  a('un', t '\\cup', { condition = math }),
  a('\\cupv', t 'u^{-1}', { condition = math }),
  a('is', t '\\cap', { condition = math }),
  a('Un', t '\\bigcup', { condition = math }),
  a('Is', t '\\bigcap', { condition = math }),
  a('sb', t '\\subset', { condition = math }),
  a('se', t '\\subseteq', { condition = math }),
  a('sn', t '\\subsetneq', { condition = math }),
  a('pr', t '\\sqsubseteq', { condition = math }),
  a('sp', t '\\supset', { condition = math }),
  a('pe', t '\\supseteq', { condition = math }),
  a('~=', t '\\cong', { condition = math }),
  a('ap', t '\\approx', { condition = math }),
  a('===', t '\\equiv', { condition = math }),
  a('ld', t '\\ldots', { condition = math }),
  a('ds', t '\\cdots', { condition = math }),
  a('si', t '\\sim', { condition = math }),
  a('nf', t '\\infty', { condition = math }),
  a('\\\\\\', t '\\setminus', { condition = math }),
  a('1n', t '\\{1, \\ldots, n\\}', { condition = math }),
  a('sm', t '\\sum', { condition = math }),
  a('\\sum_', fmta('\\sum_{<>}^<>', { i(1), i(2) }), { condition = math }),
  a('it', t '\\int', { condition = math }),
  a('\\int_', fmta('\\int_{<>}^<>', { i(1), i(2) }), { condition = math }),
  a('pd', t '\\prod', { condition = math }),
  a('\\prod_', fmta('\\prod_{<>}^<>', { i(1), i(2) }), { condition = math }),
  a('ps', t '\\sum_{k=0}^\\infty', { condition = math }),
  a('pm', t '\\pm', { condition = math }),
  a('ub', fmta('\\underbrace{<>}_{<>}', { d(1, get_visual), i(2) }), { condition = math }),
  a('sr', fmta('\\sqrt{<>}', i(1)), { condition = math }),
  a('\\simn', t '\\sin', { condition = math }),
  a('\\mathcal{O}s', t '\\cos', { condition = math }),
  a('tan', t '\\tan', { condition = math }),
  a('ln', t '\\ln', { condition = math }),
  a('pt', t '\\partial', { condition = math }),
  a('min', t '\\min', { condition = math }),
  a('max', t '\\max', { condition = math }),
  a('sup', t '\\sup', { condition = math }),
  a('inf', t '\\inf', { condition = math }),
  a('log', t '\\log', { condition = math }),
  a('lm', fmta('\\lim_{<>}', i(1)), { condition = math }),
  a('ls', fmta('\\limsup_{<>}', i(1)), { condition = math }),
  a('li', fmta('\\liminf_{<>}', i(1)), { condition = math }),
  a('and', t '\\wedge', { condition = math }),
  a('or', t '\\vee', { condition = math }),
  a('not', t '\\neg', { condition = math }),
  a('fa', t '\\forall', { condition = math }),
  a('te', t '\\exists', { condition = math }),
  a('ot', t '\\xrightarrow{1-1}', { condition = math }),
  a('on', t '\\xrightarrow{onto}', { condition = math }),

  -- fancier math things
  ms({
    common = { trig = '([^%s]+)th', wordTrig = false, regTrig = true },
    { snippetType = 'autosnippet', condition = math },
    { snippetType = 'snippet', condition = -math },
  }, {
    f(function(_, snip)
      local c = snip.captures[1]
      local suffix = c:sub(-2, -2) ~= '1' and ({ 'st', 'nd', 'rd' })[tonumber(c:sub(-1))] or 'th'
      return (math() and '%s^{%s}' or '$%s^{%s}$'):format(c, suffix)
    end),
  }),

  -- things that only happen on line_begin
  a('hl', t '\\hline', { condition = line_begin }),
  a('im', t { '\\item', '\t' }, { condition = line_begin * -math }),
  a('pl', fmta('\\addplot[<>] {<>};', { i(1), i(2) }), { condition = line_begin }),
  a('sec', fmta('\\section{<>}', i(1)), { condition = line_begin * -math }),
  a('sub', fmta('\\subsection{<>}', i(1)), { condition = line_begin * -math }),
  a('sc', fmta('\\section*{<>}', i(1)), { condition = line_begin * -math }),
  a('sb', fmta('\\subsection*{<>}', i(1)), { condition = line_begin * -math }),
  a('pf', t '\\textbf{Proof:} ', { condition = line_begin * -math }),
  a('df', t '\\textbf{Definition:} ', { condition = line_begin * -math }),
  a('nt', t '\\textbf{Note:} ', { condition = line_begin * -math }),
  a('ex', t '\\textbf{Example:} ', { condition = line_begin * -math }),

  -- text formatting
  s('tt', fmta('\\texttt{<>}', d(1, get_visual))),
  s('it', fmta('\\textit{<>}', d(1, get_visual))),
  s('bf', fmta('\\textbf{<>}', d(1, get_visual))),
  s('un', fmta('\\underline{<>}', d(1, get_visual))),

  -- environments
  a('nn', fmta('\\begin{<>}\n\t<>\n\\end{<>}', { i(1), i(2), r(1) }), { condition = line_begin }),
  a('qq', fmta('\\begin{equation}\n\t<>\n\\end{equation}', i(1)), { condition = line_begin }),
  a('q*', fmta('\\begin{equation*}\n\t<>\n\\end{equation*}', i(1)), { condition = line_begin }),
  a('gg', fmta('\\begin{gather}\n\t<>\n\\end{gather}', i(1)), { condition = line_begin }),
  a('g*', fmta('\\begin{gather*}\n\t<>\n\\end{gather*}', i(1)), { condition = line_begin }),
  a('aa', fmta('\\begin{align}\n\t<>\n\\end{align}', i(1)), { condition = line_begin }),
  a('a*', fmta('\\begin{align*}\n\t<>\n\\end{align*}', i(1)), { condition = line_begin }),
  a('ol', fmta('\\begin{enumerate}\n\t\\item\n\t\t<>\n\\end{enumerate}', i(1)), { condition = line_begin }),
  a('ul', fmta('\\begin{itemize}\n\t\\item\n\t\t<>\n\\end{itemize}', i(1)), { condition = line_begin }),
  a('ar', fmta('\\begin{array}{<>}\n\t<>\n\\end{array}', { i(1), i(2) }), { condition = line_begin }),
  a('cn', fmta('\\begin{center}\n\t<>\n\\end{center}', i(1)), { condition = line_begin }),
  a('pw', fmta('\\left\\{\n\\begin{aligned}\n\t<>\n\\end{aligned}\n\\right.', { i(1) }), { condition = line_begin }),
  a('mc', fmta('\\begin{multicols}{<>}\n\t<>\n\\end{multicols}', { i(1), i(2) }), { condition = line_begin }),
  a('tk', fmta('\\begin{tikzpicture}\n\t<>\n\\end{tikzpicture}', i(1)), { condition = line_begin }),
  a('ax', fmta('\\begin{axis}[<>]\n\t<>\n\\end{axis}', { i(1), i(2) }), { condition = line_begin }),

  -- surrounders
  a('ng', fmta('\\langle <> \\rangle', i(1)), { condition = math }),
  a('fl', fmta('\\lfloor <> \\rfloor', i(1)), { condition = math }),
  a('el', fmta('\\lceil <> \\rceil', i(1)), { condition = math }),
  a('st', fmta('\\{<>\\}', i(1)), { condition = math }),
  a('av', fmta('\\lvert <> \\rvert', i(1)), { condition = math }),
  a('aV', fmta('\\lVert <> \\rVert', i(1)), { condition = math }),
  a('[[', fmta('\\llbracket <> \\rrbracket', i(1)), { condition = math }),
  a({
    trig = '``',
    -- we need to clear out the extra ' generated by the single ` snippet
    resolveExpandParams = function(_, _, trigger)
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      return {
        clear_region = {
          from = { row - 1, col - #trigger },
          to = { row - 1, col + 1 },
        },
      }
    end,
  }, fmta("``<>''", i(1)), { condition = -math }),
  a('`', fmta("`<>'", i(1)), { condition = -math }),

  -- blackboard bold
  a('bb', fmta('\\mathbb{<>}', d(1, get_visual)), { condition = math }),
  a(
    { trig = '%f[%w]b([a-z01])', wordTrig = false, regTrig = true },
    fmta('\\mathbb{<>}', {
      l(l.CAPTURE1:gsub('[^ij]', string.upper)),
    }),
    { condition = math }
  ),

  -- caligraphic typeface
  a('cal', fmta('\\mathcal{<>}', d(1, get_visual)), { condition = math }),
  a(
    { trig = '%f[%w]c([a-z])', wordTrig = false, regTrig = true },
    fmta('\\mathcal{<>}', {
      l(l.CAPTURE1:upper()),
    }),
    { condition = math }
  ),

  -- script font
  a('scr', fmta('\\mathscr{<>}', d(1, get_visual)), { condition = math }),
  a(
    { trig = '%f[%w]S([a-z])', wordTrig = false, regTrig = true },
    fmta('\\mathscr{<>}', {
      l(l.CAPTURE1:upper()),
    }),
    { condition = math }
  ),

  -- things that require text in math mode
  a('tx', fmta('\\text{<>}', d(1, get_visual)), { condition = math }),
  a('gcd', fmta('\\text{gcd}(<>)', i(1)), { condition = math }),
  a('ord', fmta('\\text{ord}(<>)', i(1)), { condition = math }),
  a('deg', fmta('\\text{deg}(<>)', i(1)), { condition = math }),
  a('ker', fmta('\\text{ker}(<>)', i(1)), { condition = math }),
  a('im', fmta('\\text{im}(<>)', i(1)), { condition = math }),
  a('Cl', fmta('\\text{Cl}(<>)', i(1)), { condition = math }),
  a('Var', fmta('\\text{Var}(<>)', i(1)), { condition = math }),
  a('tfa', t '\\text{ for all }', { condition = math }),
  a('\\tand', t '\\text{ and }', { condition = math }),
  a('tor', t '\\text{ or }', { condition = math }),
  a('\\text{ or }d', fmta('\\text{ord}(<>)', i(1)), { condition = math }),
  a('if', t '\\text{ if }', { condition = math }),
  a('mod', t '\\text{ mod }', { condition = math }),
  a('Int', t '\\text{Int\\,}', { condition = math }),
  a('Bd', t '\\text{Bd\\,}', { condition = math }),

  -- misc.
  a('qed', t '\\hfill $\\blacksquare$', { condition = -math }),

  a({ trig = '%_([^{][^%s%(%)%[%]%{%}%.%,%^]+)', wordTrig = false, regTrig = true }, fmta('_{<><>}', { l(l.CAPTURE1), i(1) }), { condition = math }),
  a({ trig = '%^([^{][^%s%(%)%[%]%{%}%.%,]+)', wordTrig = false, regTrig = true }, fmta('^{<><>}', { l(l.CAPTURE1), i(1) }), { condition = math }),
  a({ trig = '(%a)(%d)', wordTrig = false, regTrig = true }, { l(l.CAPTURE1 .. '_' .. l.CAPTURE2) }, { condition = math }),

  -- regular snippet, not auto
  s({ trig = '%?(.*)', wordTrig = false, regTrig = true, priority = 1e6 }, l(l.CAPTURE1), { condition = math }),
  -- triggers on a space
  a({ trig = '%?(.* )', wordTrig = false, regTrig = true, priority = 1e6 }, l(l.CAPTURE1), { condition = math }),
  a({ trig = '(%?.+)', wordTrig = false, regTrig = true, priority = 1e6 }, l(l.CAPTURE1), { condition = math }),
})
