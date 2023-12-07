

library(shiny)
library(leaflet)
library(maps)
library(maptools)


genotype_frequencies = readRDS("./www/genotype_frequencies.RDS")
phenotype_frequencies = readRDS("./www/phenotype_frequencies.RDS")

ui = navbarPage("Interactive World Maps of Lactose Persistence",
  tabPanel(title = "1) Phenotype Frequencies", 
           "With this interactive map we present and summarize all the Lactase Persistence frequency data reported in the scientific literature until July 2020. This tool incorporates detailed information on the geographical location, ethnicity, number of individuals analyzed, reported frequency and reference for each included study. Interactive mapping involves zooming in and out, panning around, identifying specific features, and querying underlying data. Therefore, our tool allows the generation of detailed reports and other means of using or visualizing information in a map. This allows a more attractive way of presenting large sets of data that would not be enough-well exploited in static plots or large tables.",
           p(""),
           "For optimal use, we recommend zooming the map until reaching the desired geographical location or country, and then investigate all reported frequencies. If there is more than one study available in a particular location, data will be displayed in the form of an interactive grey cluster. The number of studies included in each cluster is indicated with a number within the circle. The geographical location mapped for all the studies of a cluster can be visualized as a blue area when moving the mouse over the circle.",
           p(""),
           leafletOutput("phenotype", height = 700)
  ),
  tabPanel(title = "2) Genotype Frequencies",
           "The genetic basis for population variation in lactase production as a dominant trait is well-described although not yet complete, with cis-element mutations responsible for Lactase Persistence identified in the transcriptional enhancer MCM6. Among identified variants, the -13910:C>T (rs4988235) and -13495:C>T (rs4954490) have almost reached fixation in some parts of Europe, while others such as -13907:C>G (rs41525747), -13915:T>G (rs41380347), -14009:T>G (rs869051967) and -14010:G>C (rs145946881) are found at variable frequencies in the Middle East and Africa. Besides highlighting as the most widespread and strongly associated Lactase Persistence variants, these six SNPs have been reported as functional markers according to a great range both in vitro transfection assays and in vivo studies.", 
          p(""), 
          "For them, we created an interactive map following the same format than the one previously-presented for Lactase Persistence phenotype data.",
          "Again, for optimal use, we recommend zooming the map until reaching the desired geographical location or country, and then investigate all reported frequencies. If there is more than one study available in a particular location, data will be displayed in the form of an interactive grey cluster. The number of studies included in each cluster is indicated with a number within the circle. The geographical location mapped for all the studies of a cluster can be visualized as a blue area when moving the mouse over the circle.", 
          p(""),
          leafletOutput("genotype", height = 700)
  ), 
  tabPanel(title = "3) Reference", 
           "Anguita-Ruiz A, Aguilera CM, Gil Á. Genetics of Lactose Intolerance: An Updated Review and Online Interactive World Maps of Phenotype and Genotype Frequencies. Nutrients. 2020 Sep 3;12(9):2689.",
           tags$a(href = "https://doi.org/10.3390/nu12092689" ,  "doi: 10.3390/nu12092689."), 
           tags$a(href = "https://pubmed.ncbi.nlm.nih.gov/32899182/", "PMID: 32899182;"),
           tags$a(href = "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7551416/", "PMCID: PMC7551416."),
           p(""), 
           "The whole data visualization process was implemented in R environment (Version 4.0.2) using
the R package leaflet, one of the most popular open-source JavaScript libraries for interactive maps.
The source code for the created visualization tool and the constructed input databases have been
shared online, so they are available for update or extension to any other application. The software has
been distributed as open-source software under the terms of the GNU Public License GPLv3, and it is
hosted in the following public hosting repository GitHub:",
           tags$a(href="https://github.com/AugustoAnguita/LactasePersistence_Interactive_WorldMaps", "https://github.com/AugustoAnguita/LactasePersistence_Interactive_WorldMaps"),
           hr(),
           tags$iframe(style="height:1000px; width:100%", src="./2020_AnguitaRuiz_Genetics_of_Lactose_Intolerance.pdf"),
           )
)

server = function(input, output){
  output$phenotype  = renderLeaflet({
    phenotype_frequencies
  })
  output$genotype  = renderLeaflet({
    genotype_frequencies
  })
}

shinyApp(ui, server)
