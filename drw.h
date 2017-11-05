#define DRW_FONT_CACHE_SIZE 32
typedef struct {
  unsigned long pix;
  XftColor rgb;
} Clr;
typedef struct {
  Cursor cursor;
} Cur;
typedef struct {
  Display *dpy;
  int ascent;
  int descent;
  unsigned int h;
  XftFont *xfont;
  FcPattern *pattern;
} Fnt;
typedef struct {
  Clr *fg;
  Clr *bg;
  Clr *border;
} ClrScheme;
typedef struct {
  unsigned int w, h;
  Display *dpy;
  int screen;
  Window root;
  Visual *visual;
  unsigned int depth;
  Colormap cmap;
  Drawable drawable;
  GC gc;
  ClrScheme *scheme;
  size_t fontcount;
  Fnt *fonts[DRW_FONT_CACHE_SIZE];
} Drw;
typedef struct {
  unsigned int w;
  unsigned int h;
} Extnts;
Drw *drw_create(Display *, int, Window, unsigned int, unsigned int, Visual*, unsigned int, Colormap);
void drw_resize(Drw *, unsigned int, unsigned int);
void drw_free(Drw *);
Fnt *drw_font_create(Drw *, const char *);
void drw_load_fonts(Drw *, const char *[], size_t);
void drw_font_free(Fnt *);
void drw_font_getexts(Fnt *, const char *, unsigned int, Extnts *);
unsigned int drw_font_getexts_width(Fnt *, const char *, unsigned int);
Clr *drw_clr_create(Drw *, const char *, unsigned int);
void drw_clr_free(Clr *);
Cur *drw_cur_create(Drw *, int);
void drw_cur_free(Drw *, Cur *);
void drw_setfont(Drw *, Fnt *);
void drw_setscheme(Drw *, ClrScheme *);
void drw_rect(Drw *, int, int, unsigned int, unsigned int, int, int, int);
int drw_text(Drw *, int, int, unsigned int, unsigned int, const char *, int);
void drw_map(Drw *, Window, int, int, unsigned int, unsigned int);
