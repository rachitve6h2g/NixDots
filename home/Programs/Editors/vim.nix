{pkgs, ...}: {
  programs.vim = {
    enable = true;

    packageConfigurable = pkgs.vim-full;

    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      ale
      lightline-vim
      catppuccin-vim
      vim-devicons
      vim-surround
      nerdtree
      vim-nerdtree-tabs
      vim-nerdtree-syntax-highlight
      lightline-gruvbox-vim
      vim-css-color
    ];

    settings = {
      expandtab = true;
      mouse = "a";
      mousefocus = true;
      mousemodel = "popup";
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
    };

    extraConfig = ''
      set nocompatible
      set nobackup
      set clipboard=unnamedplus
      filetype on
      filetype plugin on
      filetype indent on
      syntax on
      set cursorline
      set cursorcolumn
      set scrolloff=10
      set nowrap
      set nowrap
      set incsearch
      set showcmd
      set showmatch
      set hlsearch
      set history=1000
      set wildmenu
      set wildmode=list:longest
      set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

       " MAPPINGS ------------------------------------ {{{
      	" Mappings code goes here.
      	inoremap jj <esc>
      	let mapleader = '\'
      	nnoremap <leader>\ :nohlsearch<CR>
      	nnoremap <space> :
      	nnoremap n nzz
      	nnoremap N Nzz
      	" You can split the window in Vim by typing :split or :vsplit.
      	" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
      	nnoremap <c-j> <c-w>j
      	nnoremap <c-k> <c-w>k
      	nnoremap <c-h> <c-w>h
      	nnoremap <c-l> <c-w>l

      	" NERDTree specific mappings.
      	" Map the F3 key to toggle NERDTree open and close.
      	nnoremap <F2> :NERDTreeToggle<CR>
      	" Have nerdtree ignore certain files and directories.
      	let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$','\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']
      	" }}}


      	" VIMSCRIPT -------------------------------------------------------------- {{{

      	" This will enable code folding.
      	" Use the marker method of folding.
      	augroup filetype_vim
      	    autocmd!
      	    autocmd FileType vim setlocal foldmethod=marker
      	augroup END

      	if (has("termguicolors"))
      		set termguicolors
      	endif


           set background=dark
      	colorscheme catppuccin_mocha
      	set noshowmode

    '';
  };
}
