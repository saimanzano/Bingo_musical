library(gridExtra)
library(grid)
library(argparse)

# PARSE ARGUMENTS
p <- ArgumentParser("Generate bingo musical cards from Exportify output")
p$add_argument("-i", "--infile", help="Input file with the Exportify csv", type="character")
p$add_argument("-n", "--cards", help="Number of cards to generate", type="numeric", default=10)
p$add_argument("-c", "--ncol", help="Number of columns", type="numeric", default=3)
p$add_argument("-r", "--nrow", help="Number of rows", type="numeric", default=5)
p$add_argument("-o", "--odir", help="output directory", type="character", default="./")
p$add_argument("-t", "--title", help="title for the cards", type="character", default="BINGO MUSICAL")
p$add_argument("-f", "--footnote", help="Footnote for the cards", type="character", default=" ")
argv <- p$parse_args()

# Export playlist to CSV with https://exportify.app/


#' Read playlist
#'
#' @param inpath path to CSV containing the Exportify output
#' @return character vector with text for bingo cards 
#' @export

read_playlist <- function(inpath) {

  playlist <- read.csv(inpath)
  playlist[,2] <- paste0(substring(playlist[,2], 1, 25))
  labels <- paste0(playlist[,2], "\n(", playlist[,4], ")")
  return(labels)
}



#' Plots cards 
#'
#' @param sample character vector with songs to be plotted 

plot_card <- function(sample, titletext, footnotetext, ncol, nrow) {
  n <- length(sample)
  dim(sample) <- c(nrow, ncol)
  table <- tableGrob(sample)
  
  grid.newpage()
  h <- grobHeight(table)
  w <- grobWidth(table)
  title <- textGrob(titletext, y=unit(0.5,"npc") + 1.8*h,
                    vjust=-1,  gp=gpar(fontsize=20))
  footnote <- textGrob(footnotetext, 
                       x=unit(0.5,"npc") - 1.8*w,
                       y=unit(0.5,"npc") - 1.8*h, 
                       vjust=1, hjust=0,gp=gpar( fontface="italic"))
  gt <- gTree(children=gList(table, title, footnote))
  return(grid.draw(gt))

} 

#' Generate bingo cards
#'
#' @param inpath path to CSV containing the Exportify output
#' @param n number of cards to be generated
#' @param ncol number of columns in bingp
#' @param nrow number of rows in bingo 
#' @param odir not output


main <- function(inpath, n, ncol=3, nrow=5, odir="/", titletext = "BINGO", footnotetext = "") {
  labels <- read_playlist(inpath)
  samples <- as.list(data.frame(replicate(n = n, expr = {sample(labels, ncol*nrow)})))
  cairo_pdf(paste0(odir, "cards.pdf" ), height = 5, width = 12, onefile = T)
  lapply(samples, plot_card, titletext=titletext, footnotetext=footnotetext, ncol=ncol, nrow=nrow)
  dev.off()
}



if (file.exists(argv$infile)) {
  main(inpath=argv$infile, 
       n=argv$cards, 
       ncol=argv$ncol, 
       nrow=argv$nrow, 
       odir=argv$odir, 
       titletext=argv$title, 
       footnotetext=argv$footnote)
} else {
  print("ERROR: Input file not found")
}
