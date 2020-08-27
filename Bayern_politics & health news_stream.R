
#This part is copied from the Console (into the R Script file) as I am not able to save it directly from there. 

#Experimenting with interactive streamgraph, with the dataset code created for the wordcloud, using piping & streamgraph library

> install.packages("remotes")
Error in install.packages : Updating loaded packages
> remotes::install_github("hrbrmstr/streamgraph")
Downloading GitHub repo hrbrmstr/streamgraph@master

Restarting R session...

Error: Unable to establish connection with R session
> install.packages("remotes")
Installing package into 'C:/Users/UIIN/Documents/R/win-library/3.6'
(as 'lib' is unspecified)
trying URL 'https://cran.rstudio.com/bin/windows/contrib/3.6/remotes_2.2.0.zip'
Content type 'application/zip' length 388649 bytes (379 KB)
downloaded 379 KB

package 'remotes' successfully unpacked and MD5 sums checked

The downloaded binary packages are in
C:\Users\UIIN\AppData\Local\Temp\RtmpayM1FE\downloaded_packages
> remotes::install_github("hrbrmstr/streamgraph")
Downloading GitHub repo hrbrmstr/streamgraph@HEAD
These packages have more recent versions available.
It is recommended to update all of them.
Which would you like to update?
  
  1: All                             
2: CRAN packages only              
3: None                            
4: glue     (1.4.0 -> 1.4.2) [CRAN]
5: ellipsis (0.3.0 -> 0.3.1) [CRAN]
6: pillar   (1.4.3 -> 1.4.6) [CRAN]
7: tibble   (3.0.1 -> 3.0.3) [CRAN]
8: dplyr    (1.0.1 -> 1.0.2) [CRAN]
9: jsonlite (1.6.1 -> 1.7.0) [CRAN]
10: tidyr    (1.1.1 -> 1.1.2) [CRAN]

Enter one or more numbers, or an empty line to skip updates:
  Installing 2 packages: zoo, xts
Installing packages into 'C:/Users/UIIN/Documents/R/win-library/3.6'
(as 'lib' is unspecified)
trying URL 'https://cran.rstudio.com/bin/windows/contrib/3.6/zoo_1.8-8.zip'
Content type 'application/zip' length 1096082 bytes (1.0 MB)
downloaded 1.0 MB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/3.6/xts_0.12-0.zip'
Content type 'application/zip' length 966360 bytes (943 KB)
downloaded 943 KB

package 'zoo' successfully unpacked and MD5 sums checked
package 'xts' successfully unpacked and MD5 sums checked

The downloaded binary packages are in
C:\Users\UIIN\AppData\Local\Temp\RtmpayM1FE\downloaded_packages
???  checking for file 'C:\Users\UIIN\AppData\Local\Temp\RtmpayM1FE\remotes3e705b8934c2\hrbrmstr-streamgraph-76f7173/DESCRIPTION' (473ms)
-  preparing 'streamgraph': (2.3s)
???  checking DESCRIPTION meta-information ... 
-  checking for LF line-endings in source and make files and shell scripts (359ms)
-  checking for empty or unneeded directories
-  building 'streamgraph_0.9.0.tar.gz'

Installing package into 'C:/Users/UIIN/Documents/R/win-library/3.6'
(as 'lib' is unspecified)
* installing *source* package 'streamgraph' ...
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
converting help for package 'streamgraph'
finding HTML links ... done
renderStreamgraph                       html  
sg_add_marker                           html  
sg_annotate                             html  
sg_axis_x                               html  
sg_axis_y                               html  
sg_colors                               html  
sg_fill_brewer                          html  
sg_fill_manual                          html  
sg_fill_tableau                         html  
sg_legend                               html  
sg_title                                html  
streamgraph-exports                     html  
streamgraph-package                     html  
streamgraph                             html  
streamgraphOutput                       html  
widgetThumbnail                         html  
** building package indices
** installing vignettes
** testing if installed package can be loaded from temporary location
*** arch - i386
*** arch - x64
** testing if installed package can be loaded from final location
*** arch - i386
*** arch - x64
** testing if installed package keeps a record of temporary installation path
* DONE (streamgraph)
> library(streamgraph)

#most frequent politics & health keywords 2018-2020: 

Keywords = c("usa","trump","polizei","kommunalwahl","spd","csu","europäische union","auto","landtagswahl","afd","merkel","cdu","finanzpolitik","migrationspolitik","nationalmannschaft","großbritannien","europawahl","türkei","russland","syrien","frankreich","china","brexit","coronavirus","covid19","medizin","corona","krankenheiten","coronakrise","psychologie")

data = read.delim("SZ_news_dataset.csv", sep = ";")
data = data[data$Date !="",]
data$Date = as.Date(data$Date, format = "%d/%m/%Y")
data$date = format(data$Date, "%m-%Y")
Final = data.frame("keyword"=rep(Keywords, time=31), date = rep(seq(from = as.Date('2018-01-01'), to = as.Date('2020-07-31'), by='months'), each = 30), size = 0)

#Loops

for(i in 1:length(Final$keyword)) {
  train = data[data$date==format(as.Date(Final$date[i], format="%Y/%m/%d"),"%m-%Y"),]
  k = 0
  for (j in 1:length(train)){
    if (str_contains(train$Keywords[j],Final$keyword[i],ignore.case = TRUE)){
      k = k+1
    }
  }
  Final$size[i] = k
  
}

#pipe function to get the dataset processed within the streamgraph function

# https://hrbrmstr.github.io/streamgraph/

p = Final %>%streamgraph("keyword", "size", "date") %>%
  sg_axis_x(1, "date", "%m-%Y") %>%
  sg_legend(show=TRUE, label="I- names: ")%>%
  sg_fill_brewer("Blues")
p


#and some other color options:

p = Final %>%streamgraph("keyword", "size", "date") %>%
  sg_axis_x(1, "date", "%m-%Y") %>%
  sg_legend(show=TRUE, label="I- names: ")%>%
  sg_fill_brewer("BuPu")
p




