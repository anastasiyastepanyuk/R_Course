### Лабораторна робота No 1. Завантаження та зчитування даних.

1. За допомогою download.file() завантажте любий excel файл з порталу http://data.gov.ua та зчитайте його (xls, xlsx – бінарні формати, тому встановить mode = “wb”. Виведіть перші 6 строк отриманого фрейму даних.
                                     
 ```R
dataUrl <- 'https://data.gov.ua/dataset/241077fe-8f9c-4545-8576-fb71399f2037/resource/31c2ff62-faf1-445d-94c7-8baed2063c36/download/zalishki-medikamentivna-01-12-2020-r.xlsx'
dstFile = 'data.xlsx'
download.file(dataUrl, dstFile, mode = 'wb')

library(readxl)
data <- read_xlsx('data.xlsx')
head(data)

# A tibble: 6 x 4
  ...1  `Залишки медикаментів на 01.12.2020 р.`   ...3               ...4         
  <chr> <chr>                                     <chr>              <chr>        
1 № п/п "Торгівельна назва"                       Форма випуску та … Наявна кільк…
2 1     "\"Гігасепт інстру АФ\" 2л засіб дезінфе… л                  1.3919999999…
3 2     "\"Неостерил\" безбарвний 1.0 дез-зас(34… л                  2            
4 3     "\"Санікон \" дезінфекційний засіб 5 л."  л                  14.31        
5 4     "\"Соліклор\"1кг(гранулы)дезинф.средство… кг                 23.1         
6 5     "ABX BASOLYSE 1л лізуюч.розч.(08479,201/… мл                 2136  
                                                                                                                                                                                                                                                                                                                                                           
```
2. За допомогою download.file() завантажте файл getdata_data_ss06hid.csv за посиланням https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv та завантажте дані в R. Code book, що пояснює значення змінних знаходиться за посиланням https://www.dropbox.com/s/dijv0rlwo4mryv5/PUMSDataDict06.pdf?dl=0
   Необхідно знайти, скільки property мають value $1000000+
  
  ```R
dataUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
dstFile = 'getdata_data_ss06hid.csv'
download.file(dataUrl, dstFile, mode = 'wb')

data <- read.csv('getdata_data_ss06hid.csv')

length(which(data$VAL==24))
[1] 53
```
3. Зчитайте xml файл за посиланням
http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml
Скільки ресторанів мають zipcode 21231?

```R
library(XML)
xmlURL <- 'http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
doc <- xmlTreeParse(restURL, useInternal=TRUE)
rest <- xmlRoot(doc)
zipcode <- xpathSApply(doc, "//zipcode", xmlValue)

length(which(zipcode==21231))                                                                                                                         
[1] 127
```
