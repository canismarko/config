$pdf_previewer = 'start evince';
$pdflatex = 'lualatex -halt-on-error %O %S';
$pdf_mode = 1;

# Extra temporary files to clean up
push @generated_exts, 'nav', 'glo', 'gls', 'glg', 'run.xml', 'tdo', 'snm', 'eps-converted-to.pdf';
