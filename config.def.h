static const char *fonts[] = {
  "monospace:size=8"
};
static const char dmenufont[]       = "monospace:size=10";
static const char normbordercolor[] = "#ff0000";
static const char normbgcolor[]     = "#000000";
static const char normfgcolor[]     = "#0f94b1";
static const char selbordercolor[]  = "#00e103";
static const char selbgcolor[]      = "#005577";
static const char selfgcolor[]      = "#eeeeee";
static unsigned int baralpha        = 0xd0;
static unsigned int borderalpha     = OPAQUE;
static const unsigned int borderpx  = 1;  
static const unsigned int snap      = 32; 
static const int showbar            = 1;  
static const int topbar             = 1;  
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
static const Rule rules[] = {
  // class      instance    title       tags mask     isfloating   monitor
  { "MPlayer",  NULL,       NULL,       0,            0,           -1 },
};
static const float mfact     = 0.67; 
static const int nmaster     = 1;    
static const int resizehints = 1;    
static const Layout layouts[] = {
  { "[T]",     tile },    
  { "[F]",     NULL },    
  { "[M]",     monocle },
  { "[G]",     gaplessgrid },
  { "[@]",     dwindle },
};
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
{ KeyPress,   MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
{ KeyPress,   MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
{ KeyPress,   MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
{ KeyPress,   MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
static char dmenumon[2] = "0";
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { "xterm", NULL };
static const char *scrot[] = { "scrot","-q","100","/data/pics/screenshots/\%s.jpg", NULL };
static const char *nextkb[] = { "/home/sasheto/bin/utils/nextkb", NULL };
static Key keys[] = {
  { KeyPress,     MODKEY,             XK_p,            spawn,          {.v = dmenucmd } },
  { KeyPress,     MODKEY|ShiftMask,   XK_Return,       spawn,          {.v = termcmd } },
  { KeyPress,     MODKEY,             XK_bracketright, spawn,          {.v = nextkb } },
  { KeyPress,     MODKEY,             XK_b,            togglebar,      {0} },
  { KeyPress,     MODKEY,             XK_j,            focusstack,     {.i = +1 } },
  { KeyPress,     MODKEY,             XK_k,            focusstack,     {.i = -1 } },
  { KeyPress,     MODKEY,             XK_i,            incnmaster,     {.i = +1 } },
  { KeyPress,     MODKEY,             XK_d,            incnmaster,     {.i = -1 } },
  { KeyPress,     MODKEY,             XK_h,            setmfact,       {.f = -0.05} },
  { KeyPress,     MODKEY,             XK_l,            setmfact,       {.f = +0.05} },
  { KeyPress,     MODKEY,             XK_Return,       zoom,           {0} },
  { KeyPress,     MODKEY,             XK_Tab,          view,           {0} },
  { KeyPress,     MODKEY|ShiftMask,   XK_c,            killclient,     {0} },
  { KeyPress,     MODKEY,             XK_t,            setlayout,      {.v = &layouts[0]} },
  { KeyPress,     MODKEY,             XK_f,            setlayout,      {.v = &layouts[1]} },
  { KeyPress,     MODKEY,             XK_m,            setlayout,      {.v = &layouts[2]} },
  { KeyPress,     MODKEY,             XK_g,            setlayout,      {.v = &layouts[3]} },
  { KeyPress,     MODKEY,             XK_s,            setlayout,      {.v = &layouts[4]} },
  { KeyPress,     MODKEY,             XK_space,        setlayout,      {0} },
  { KeyPress,     MODKEY|ShiftMask,   XK_space,        togglefloating, {0} },
  { KeyPress,     MODKEY,             XK_0,            view,           {.ui = ~0 } },
  { KeyPress,     MODKEY|ShiftMask,   XK_0,            tag,            {.ui = ~0 } },
  { KeyPress,     MODKEY,             XK_comma,        focusmon,       {.i = -1 } },
  { KeyPress,     MODKEY,             XK_period,       focusmon,       {.i = +1 } },
  { KeyPress,     MODKEY|ShiftMask,   XK_comma,        tagmon,         {.i = -1 } },
  { KeyPress,     MODKEY|ShiftMask,   XK_period,       tagmon,         {.i = +1 } },
  { KeyRelease,   MODKEY,             XK_Print,        spawn,          {.v = scrot } },
  TAGKEYS( XK_1, 0)
  TAGKEYS( XK_2, 1)
  TAGKEYS( XK_3, 2)
  TAGKEYS( XK_4, 3)
  TAGKEYS( XK_5, 4)
  TAGKEYS( XK_6, 5)
  TAGKEYS( XK_7, 6)
  TAGKEYS( XK_8, 7)
  TAGKEYS( XK_9, 8)
  { KeyRelease,   MODKEY|ShiftMask,   XK_q,            quit,           {0} },
};
static Button buttons[] = {
  { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
  { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
  { ClkWinTitle,          0,              Button2,        zoom,           {0} },
  { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
  { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
  { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
  { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
  { ClkTagBar,            0,              Button1,        view,           {0} },
  { ClkTagBar,            0,              Button3,        toggleview,     {0} },
  { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
  { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
