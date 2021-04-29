NAME = libenchant_win8.dll
OBJDIR = ./OBJDIR
SRCDIR = ./
LDFLAGS = $(shell pkg-config --libs glib-2.0 enchant-2) -lole32
CPPFLAGS = $(shell pkg-config --cflags glib-2.0 enchant-2) -DNTDDI_VERSION=NTDDI_WIN8

cpp_src = ./win8_provider.cpp
cpp_obj = $(patsubst $(SRCDIR)/%.cpp,$(OBJDIR)/%.obj,$(cpp_src))
def_src = $(wildcard $(SRCDIR)/*.def)

all: $(OBJDIR) $(NAME)

$(OBJDIR):
	@mkdir -p $(OBJDIR)
    
$(NAME): $(cpp_obj) $(def_obj)
	$(CXX) $^ -shared $(CPPFLAGS) $(LDFLAGS)
	

$(cpp_obj): $(OBJDIR)/%.obj: $(SRCDIR)/%.cpp 
	$(CXX) -c $(LDFLAGS) $< -o $(OBJDIR)/$*.obj
