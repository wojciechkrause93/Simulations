##### Lekarz przyjmuje pacjent�w zgodnie z rozk�adem Poisson'a ze �redni� 
##### r�wn� 10 minut i pracuje przez 8h. Zapisanych jest 48 pacjent�w, gdzie
#### za�o�eniem jest �e ka�dy pacjent w gabinecie b�dzie 10 minut. 
#### Jaki jest procent, �e doktor b�dzie musia� zosta� po godzinach
#### pracy aby przyj�� wszystkich pacjent�w, jaki �e wyjdzie r�wno o swojej godzinie,
#### jaki �e b�dzie m�g� wyj�� szybciej z pracy?
#### Jaki procent pacjent�w b�dzie musia�o wej�� sp�nionych do gabinetu?
Doktor.Dom = c()
liczba.spoznien = c()
czas.ca�kowity = 60*8
czas = seq(0, czas.ca�kowity, 10)
histogram = c()
N = 1000
for(i in 1:N)
{
  losp = rpois(48, 10)
  los = c(0, cumsum(losp))
  df = data.frame(czas, los)
  df$roznica = df$czas - df$los
  spoznienie.pacjentow = length(which(df$roznica>0))
  x = ifelse(df$roznica[length(df$roznica)]>0, "Zostaje po pracy",
             ifelse(df$roznica[length(df$roznica)]==0, "Wychodzi r�wno",
                    ifelse(df$roznica[length(df$roznica)]<0, "Wychodzi wcze�niej")))
  Doktor.Dom = c(Doktor.Dom, x)
  liczba.spoznien = c(liczba.spoznien, spoznienie.pacjentow)
  histogram = c(histogram, losp)
}

histogram = data.frame(histogram)
library(ggplot2)
ggplot(data = histogram, aes(x = histogram))+
  geom_histogram(binwidth = 1, col = "red", fill = "green", alpha = 0.2) + 
  labs(title = "Rozk�ad sp�dzania czasu u doktora") + 
  xlab("Rozk�ad czasu") + 
  ylab("Liczebno��") + 
  theme(axis.text.x = element_text(size =15),
        axis.text.y = element_text(size =15),
        title = element_text(size = 15),
        axis.title.y = element_text(size = 18),
        axis.title.x = element_text(size = 18))
table(Doktor.Dom)/N
print(paste("Udzia� os�b kt�re wejd� sp�nione do gabinetu wynosi =", sum(liczba.spoznien)/N, "%"))
