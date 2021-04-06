NAME = libenchant_win8.dll
OBJDIR = ./OBJDIR
SRCDIR = ./
LDFLAGS = "`pkg-config --libs glib-2.0 enchant-2`"
CPPFLAGS = "`pkg-config --cflags glib-2.0 enchant-2`"

cpp_src = ./win8_provider.cpp
cpp_obj = $(patsubst $(SRCDIR)/%.cpp,$(OBJDIR)/%.obj,$(cpp_src))
def_src = $(wildcard $(SRCDIR)/*.def)

all: $(OBJDIR) $(NAME)

$(OBJDIR):
	@mkdir -p $(OBJDIR)
    
$(NAME): $(cpp_obj) $(def_obj)
	$(CXX) $^ $(LDFLAGS) 
	dllwrap --def $(def_obj) -dllname $(NAME) $(cpp_obj)

$(cpp_obj): $(OBJDIR)/%.obj: $(SRCDIR)/%.cpp 
	$(CXX) -c $(CPPFLAGS) $< -o $(OBJDIR)/$*.obj