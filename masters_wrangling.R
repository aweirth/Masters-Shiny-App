masters <- read.csv("/Users/alexweirth/Documents/data_viz_502/final_project/masters2021_cleaned.csv")

# Making Normal Names

names_split <- strsplit(masters$player_name, ", ")
masters$player <- sapply(names_split, function(x) paste(rev(x), collapse = " "))


# Adding Winnings

# Create a vector for each column
# Create a vector for each column
# Create a vector for each column
position <- c(
  "1", "2", "T3", "T3", "T5", "T5", "7", "T8", "T8", "T10", "T10", "T12", "T12", "T12",
  "T12", "T12", "T12", "T18", "T18", "T18", "T21", "T21", "T21", "T21", "T21", "T26",
  "T26", "T26", "T26", "T26", "T26", "T26", "T26", "T34", "T34", "T34", "T34",
  "T38", "T38", "T40", "T40", "T40", "T40", "T40", "T40", "T46", "T46", "T46", "49", "T50",
  "T50", "52", "53", "54"
)
player_name <- c(
  "Hideki Matsuyama", "Will Zalatoris", "Xander Schauffele", "Jordan Spieth",
  "Marc Leishman", "Jon Rahm", "Justin Rose", "Corey Conners", "Patrick Reed",
  "Tony Finau", "Cameron Smith", "Stewart Cink", "Brian Harman", "Si Woo Kim",
  "Robert MacIntyre", "Kevin Na", "Webb Simpson", "Tyrrell Hatton", "Collin Morikawa",
  "Scottie Scheffler", "Harris English", "Viktor Hovland", "Shane Lowry", "Phil Mickelson",
  "Justin Thomas", "Abraham Ancer", "Paul Casey", "Cameron Champ", "Matt Jones",
  "Louis Oosthuizen", "Ian Poulter", "Charl Schwartzel", "Bubba Watson", "Matt Fitzpatrick",
  "Ryan Palmer", "Michael Thompson", "Matt Wallace", "Martin Laird", "Henrik Stenson",
  "Christiaan Bezuidenhout", "Mackenzie Hughes", "Sebastián Muñoz", "Joaquin Niemann",
  "Bernd Wiesberger", "Gary Woodland", "Bryson DeChambeau", "Tommy Fleetwood",
  "Brendon Todd", "Jason Kokrak", "Billy Horschel", "José María Olazábal", "Francesco Molinari",
  "Jim Herman", "Adam Scott"
)
score_to_par <- c(
  -10, -9, -7, -7, -6, -6, -5, -4, -4, -3, -3, -2, -2, -2, -2, -2, -2, -1, -1, -1,
  0, 0, 0, 0, 0, +1, +1, +1, +1, +1, +1, +1, +1, +2, +2, +2, +2, +3, +3, +4, +4, +4, +4, +4, +4, +5, +5,
  +5, +7, +8, +8, +9, +10, +11
)
winnings <- c(
  2070000, 1242000, 667000, 667000, 437000, 437000, 385250, 345000, 345000, 299000,
  299000, 218500, 218500, 218500, 218500, 218500, 218500, 161000, 161000, 161000,
  119600, 119600, 119600, 119600, 119600, 79925, 79925, 79925, 79925,
  79925, 79925, 79925, 79925, 60663, 60663, 60663, 60663, 52900, 52900, 43700, 43700,
  43700, 43700, 43700, 43700, 33503, 33503, 33503, 29900, 28635, 28635, 27600, 27140, 26680
)

# Create the DataFrame
lb_df <- data.frame(position = position, player_name = player_name, score_to_par = score_to_par, winnings = winnings)

# Display the DataFrame
lb_df

masters <- masters %>%
  left_join(lb_df, by = c("player" = "player_name"))

masters <- masters %>%
  mutate(winnings_char = scales::dollar(winnings, prefix = "$"))

masters_lb <- masters %>%
  mutate(round_char = as.factor(case_when(
    round_num == 1 ~ "rd1",
    round_num == 2 ~ "rd2",
    round_num == 3 ~ "rd3",
    round_num == 4 ~ "rd4",
  ))) %>%
  pivot_wider(names_from = "round_char", values_from = "round_score") %>%
  select(position, player, rd1, rd2, rd3, rd4, score_to_par, winnings_char) %>%
  group_by(player) %>%
  summarize(
    position = first(position),
    score_to_par = first(score_to_par),
    winnings_char = first(winnings_char),
    rd1 = mean(rd1, na.rm = TRUE),
    rd2 = mean(rd2, na.rm = TRUE),
    rd3 = mean(rd3, na.rm = TRUE),
    rd4 = mean(rd4, na.rm = TRUE)
  ) 

# Convert the "position" column to an ordinal factor with custom levels
custom_levels <- c("1", "2", "T3", "T5", "7", "T8", "T10", "T12", "T18", "T21", "T26", "T34", "40", "49", "50", "52", "53", "54")
masters_lb$position <- factor(masters_lb$position, levels = custom_levels, ordered = TRUE)

# Arrange leader board
masters_lb <- masters_lb %>%
  select(position, player, rd1, rd2, rd3, rd4, score_to_par, winnings_char) %>%
  arrange(score_to_par)

write_csv(masters_lb, "/Users/alexweirth/Documents/data_viz_502/final_project/masters2021_lb.csv")

write_csv(masters_ln, "/Users/alexweirth/Documents/data_viz_502/final_project/masters2021_lb.csv")