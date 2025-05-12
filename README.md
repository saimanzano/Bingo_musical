# Bingo_musical
Script to generate a bingo musical from Exportify output. Exportify generates a .csv file from your Spotify playlists.

usage: Generate bingo musical cards from Exportify output [-h] [-i INFILE]
                                                          [-n CARDS] [-c NCOL]
                                                          [-r NROW] [-o ODIR]
                                                          [-t TITLE]
                                                          [-f FOOTNOTE]
```
options:
  -h, --help            show this help message and exit
  -i INFILE, --infile INFILE
                        Input file with the Exportify csv 
  -n CARDS, --cards CARDS
                        Number of cards to generate (default 10)
  -c NCOL, --ncol NCOL  Number of columns (default 3)
  -r NROW, --nrow NROW  Number of rows (default 5)
  -o ODIR, --odir ODIR  output directory (default "./")
  -t TITLE, --title TITLE
                        title for the cards (default "BINGO MUSICAL")
  -f FOOTNOTE, --footnote FOOTNOTE
                        Footnote for the cards (default none)

```
