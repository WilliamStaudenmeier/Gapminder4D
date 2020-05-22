devtools::install_github("tylermorganwall/rayshader")

library(gapminder)
library(rayshader)
library(ggplot2)
library(maps)
library(dplyr)
library(magick)



data(gapminder)

distinct(gapminder$year)

maps = data(worldmap)


list = c("1952", "1957", "1962", "1967", "1972", "1977", "1982", "1987", "1992", "1997", "2002", "2007")


world = na.omit(world)

world$country = world$region


gapminder$country = gsub("Congo, Dem. Rep.", "Republic of Congo", gapminder$country) %>%
  
  gsub("United States", "USA", gapminder$country) %>%

  gsub("United Kingdom", "UK", gapminder$country)





list = as.list(unique(world$year))



for (i in list) {
  

  
  plot =ggplot(world %>% filter(year==i), aes(x = long, y = lat, group = group, color = lifeExp/gdpPercap)) +
    geom_polygon() +
     ggtitle(i)  + 
    theme(legend.position = "none")
    
  
  
  img_frames <- paste0(i, ".png")
  plot_gg(plot, width = 5, height = 5, multicore = TRUE, scale = 250, 
          zoom = 0.7, theta = 10, phi = 30, windowsize = c(800, 800))
  render_snapshot(img_frames)
  rgl::clear3d()
}




magick::image_write_gif(magick::image_read(list),
                        path = "montereybay.gif", 
                        delay = 1/2)


####


