library(lintr)
library(httr)
library(jsonlite)
library(dplyr)
library(tidyr)
library(ggplot2)
datasets_url_marsweather <- "https://api.nasa.gov/insight_weather/?api_key=DEMO_KEY&feedtype=json&ver=1.0"
token <- "LrbYghaMNS4IryysggrAkDMdsFtjQzwVqQsMzY4J"
call_weather <- GET(datasets_url_marsweather, add_headers("Token" = token))
dataset_weather <- content(call_weather, as = "text")
dataset_weather <- fromJSON(dataset_weather)

AT <- c(dataset_weather$"364"$AT$av, dataset_weather$"365"$AT$av,
       dataset_weather$"366"$AT$av, dataset_weather$"367"$AT$av,
       dataset_weather$"368"$AT$av, dataset_weather$"369"$AT$av,
       dataset_weather$"370"$AT$av, dataset_weather$"371"$AT$a,
       dataset_weather$"372"$AT$av, dataset_weather$"373"$AT$av,
       dataset_weather$"374"$AT$a, dataset_weather$"375"$AT$av,
       dataset_weather$"376"$AT$av, dataset_weather$"377"$AT$av,
       dataset_weather$"378"$AT$av, dataset_weather$"379"$AT$av,
       dataset_weather$"380"$AT$av)

MN <- c(dataset_weather$"362"$AT$mn, dataset_weather$"363"$AT$mn,
       dataset_weather$"364"$AT$mn, dataset_weather$"365"$AT$mn,
       dataset_weather$"366"$AT$mn, dataset_weather$"367"$AT$mn,
       dataset_weather$"368"$AT$mn, dataset_weather$"369"$AT$mn,
       dataset_weather$"370"$AT$mn, dataset_weather$"371"$AT$mn,
       dataset_weather$"372"$AT$mn, dataset_weather$"373"$AT$mn,
       dataset_weather$"374"$AT$mn, dataset_weather$"375"$AT$mn,
       dataset_weather$"376"$AT$mn, dataset_weather$"377"$AT$mn,
       dataset_weather$"378"$AT$mn, dataset_weather$"379"$AT$mn,
       dataset_weather$"380"$AT$mn)

MX <- c(dataset_weather$"362"$AT$mx, dataset_weather$"363"$AT$mx,
       dataset_weather$"364"$AT$mx, dataset_weather$"365"$AT$mx,
       dataset_weather$"366"$AT$mx, dataset_weather$"367"$AT$mx,
       dataset_weather$"368"$AT$mx, dataset_weather$"369"$AT$mx,
       dataset_weather$"370"$AT$mx, dataset_weather$"371"$AT$mx,
       dataset_weather$"372"$AT$mx, dataset_weather$"373"$AT$mx,
       dataset_weather$"374"$AT$mx, dataset_weather$"375"$AT$mx,
       dataset_weather$"376"$AT$mx, dataset_weather$"377"$AT$mx,
       dataset_weather$"378"$AT$mx, dataset_weather$"379"$AT$mx,
       dataset_weather$"380"$AT$mx)

sol <- dataset_weather$sol_keys
alldata <- data.frame (Day = sol, Minimum_temperature = MX,
          Average_Temperature = AT, Maximum_Temperature = MN)

ggplot(data = alldata) +
  geom_point (mapping = aes (x = Day,
           y = Minimum_temperature, colour = "max")) +
  geom_line (mapping = aes (x = Day,
           y = Minimum_temperature, group = 1, colour = "max")) +
  geom_point (mapping = aes (x = Day,
           y = Average_Temperature, colour = "average")) +
  geom_line (mapping = aes (x = Day, y = Average_Temperature,
              group = 1, colour = "average")) +
  geom_point (mapping = aes (x = Day, y = Maximum_Temperature,
              colour = "min")) +
  geom_line (mapping = aes (x = Day, y = Maximum_Temperature,
              group = 1, colour = "min")) +
  ggtitle ("����������� �� �����") +
  xlab ("��������� ���� �� ����� (�)") +
  ylab ("�C") +
  ylim (-150, 0)
