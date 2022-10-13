
# modified function 'gsInfo' from bioc/enrichplot/src/R/gseaplot.R
gsInfo_local <- function(object, geneSetID) {
  geneList <- object@geneList
  
  if (is.numeric(geneSetID))
    geneSetID <- object@result[geneSetID, "ID"]
  
  geneSet <- object@geneSets[[geneSetID]]
  exponent <- object@params[["exponent"]]
  df <- gseaScores(geneList, geneSet, exponent, fortify=TRUE)
  df$ymin <- 0
  df$ymax <- 0
  pos <- df$position == 1
  h <- diff(range(df$runningScore))/20
  df$ymin[pos] <- -h
  df$ymax[pos] <- h
  df$geneList <- geneList
  
  df$Description <- object@result[geneSetID, "Description"]
  return(df)
}

gseaScores <- getFromNamespace("gseaScores", "DOSE")

# modified function 'gseaplot.gseaResult' from bioc/enrichplot/src/R/gseaplot.R
gseaplot_local <- function (x, geneSetID, by = "all", title = "",
                                 color='black', color.line="green",
                                 color.vline="#FA5860", title.font.size=13, axis.font.size=10,...){
  by <- match.arg(by, c("runningScore", "preranked", "all"))
  gsdata <- gsInfo_local(x, geneSetID)
  p <- ggplot(gsdata, aes_(x = ~x)) +
       xlab("Position in Ranked List of Genes") + 
       theme(plot.title=element_text(hjust=0.5, size=title.font.size),
              axis.title.y=element_text(size=axis.font.size), 
              axis.title.x=element_text(size=axis.font.size))
  if (by == "runningScore" || by == "all") {
    p.res <- p + geom_linerange(aes_(ymin=~ymin, ymax=~ymax), color=color)
    p.res <- p.res + geom_line(aes_(y = ~runningScore), color=color.line,
                               size=1)
    enrichmentScore <- x@result[geneSetID, "enrichmentScore"]
    es.df <- data.frame(es = which.min(abs(p$data$runningScore - enrichmentScore)))
    p.res <- p.res + geom_vline(data = es.df, aes_(xintercept = ~es),
                                colour = color.vline, linetype = "dashed")
    p.res <- p.res + ylab("Running Enrichment Score")
    p.res <- p.res + geom_hline(yintercept = 0)
  }
  if (by == "preranked" || by == "all") {
    df2 <- data.frame(x = which(p$data$position == 1))
    df2$y <- p$data$geneList[df2$x]
    p.pos <- p + geom_segment(data=df2, aes_(x=~x, xend=~x, y=~y, yend=0),
                              color=color)
    p.pos <- p.pos + ylab("Ranked List Metric") +
      xlim(0, length(p$data$geneList))
  }
  if (by == "runningScore")
    return(p.res + ggtitle(title))
  if (by == "preranked")
    return(p.pos + ggtitle(title))
  
  p.pos <- p.pos + xlab(NULL) + theme(axis.text.x = element_text(size=axis.font.size),
                                      axis.ticks.x = element_blank())
  p.pos <- p.pos + ggtitle(title)
  plot_grid(p.pos, p.res, ncol=1, align="v")
}
