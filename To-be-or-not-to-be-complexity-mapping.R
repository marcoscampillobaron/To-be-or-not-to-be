get_complexity_mapping <- function() {
  complexity_mapping <- data.frame(
    size = character(),
    correlation = character(),
    complexity = character(),
    mu = numeric(),
    sigma = numeric(),
    stringsAsFactors = FALSE
  )
  
  # ---- N2M1 ----
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M1",
    correlation = "1dependent",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M1",
    correlation = "1dependent",
    complexity = "medium",
    mu = 0.6,
    sigma = 0.5
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M1",
    correlation = "1dependent",
    complexity = "hard",
    mu = 0.5,
    sigma = 0.25
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M1",
    correlation = "dcp",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M1",
    correlation = "dcp",
    complexity = "medium",
    mu = 0.6,
    sigma = 0.5
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M1",
    correlation = "dcp",
    complexity = "hard",
    mu = 0.5,
    sigma = 0.25
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M1",
    correlation = "exchangeable",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M1",
    correlation = "exchangeable",
    complexity = "medium",
    mu = 0.6,
    sigma = 0.5
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M1",
    correlation = "exchangeable",
    complexity = "hard",
    mu = 0.5,
    sigma = 0.25
  ))
  
  # ---- N2M2 ----
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M2",
    correlation = "1dependent",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M2",
    correlation = "1dependent",
    complexity = "medium",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M2",
    correlation = "1dependent",
    complexity = "hard",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M2",
    correlation = "dcp",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M2",
    correlation = "dcp",
    complexity = "medium",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M2",
    correlation = "dcp",
    complexity = "hard",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M2",
    correlation = "exchangeable",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M2",
    correlation = "exchangeable",
    complexity = "medium",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M2",
    correlation = "exchangeable",
    complexity = "hard",
    mu = 0.5,
    sigma = 1
  ))
  
  # ---- N2M3 ----
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M3",
    correlation = "1dependent",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M3",
    correlation = "1dependent",
    complexity = "medium",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M3",
    correlation = "1dependent",
    complexity = "hard",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M3",
    correlation = "dcp",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M3",
    correlation = "dcp",
    complexity = "medium",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M3",
    correlation = "dcp",
    complexity = "hard",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M3",
    correlation = "exchangeable",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M3",
    correlation = "exchangeable",
    complexity = "medium",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N2M3",
    correlation = "exchangeable",
    complexity = "hard",
    mu = 0.5,
    sigma = 1
  ))
  
  # ---- N3M1 ----
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M1",
    correlation = "1dependent",
    complexity = "easy",
    mu = 0.8,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M1",
    correlation = "1dependent",
    complexity = "medium",
    mu = 0.9,
    sigma = 0.1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M1",
    correlation = "1dependent",
    complexity = "hard",
    mu = 0.6,
    sigma = 0.1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M1",
    correlation = "dcp",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M1",
    correlation = "dcp",
    complexity = "medium",
    mu = 0.6,
    sigma = 0.25
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M1",
    correlation = "dcp",
    complexity = "hard",
    mu = 0.5,
    sigma = 0.5
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M1",
    correlation = "exchangeable",
    complexity = "easy",
    mu = 0.6,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M1",
    correlation = "exchangeable",
    complexity = "medium",
    mu = 0.5,
    sigma = 0.75
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M1",
    correlation = "exchangeable",
    complexity = "hard",
    mu = 0.5,
    sigma = 0.5
  ))
  
  # ---- N3M2 ----
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M2",
    correlation = "1dependent",
    complexity = "easy",
    mu = 0.5,
    sigma = 0.5
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M2",
    correlation = "1dependent",
    complexity = "medium",
    mu = 0.5,
    sigma = 0.25
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M2",
    correlation = "1dependent",
    complexity = "hard",
    mu = 0.5,
    sigma = 0.1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M2",
    correlation = "dcp",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M2",
    correlation = "dcp",
    complexity = "medium",
    mu = 0.5,
    sigma = 0.25
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M2",
    correlation = "dcp",
    complexity = "hard",
    mu = 0.5,
    sigma = 0.1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M2",
    correlation = "exchangeable",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M2",
    correlation = "exchangeable",
    complexity = "medium",
    mu = 0.5,
    sigma = 0.5
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M2",
    correlation = "exchangeable",
    complexity = "hard",
    mu = 0.5,
    sigma = 0.1
  ))
  
  # ---- N3M3 ----
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M3",
    correlation = "1dependent",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M3",
    correlation = "1dependent",
    complexity = "medium",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M3",
    correlation = "1dependent",
    complexity = "hard",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M3",
    correlation = "dcp",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M3",
    correlation = "dcp",
    complexity = "medium",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M3",
    correlation = "dcp",
    complexity = "hard",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M3",
    correlation = "exchangeable",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M3",
    correlation = "exchangeable",
    complexity = "medium",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N3M3",
    correlation = "exchangeable",
    complexity = "hard",
    mu = 0.5,
    sigma = 1
  ))
  
  # ---- N4M1 ----
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M1",
    correlation = "1dependent",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M1",
    correlation = "1dependent",
    complexity = "medium",
    mu = 0.6,
    sigma = 0.25
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M1",
    correlation = "1dependent",
    complexity = "hard",
    mu = 0.6,
    sigma = 0.1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M1",
    correlation = "dcp",
    complexity = "easy",
    mu = 0.6,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M1",
    correlation = "dcp",
    complexity = "medium",
    mu = 0.5,
    sigma = 0.75
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M1",
    correlation = "dcp",
    complexity = "hard",
    mu = 0.6,
    sigma = 0.1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M1",
    correlation = "exchangeable",
    complexity = "easy",
    mu = 0.6,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M1",
    correlation = "exchangeable",
    complexity = "medium",
    mu = 0.5,
    sigma = 0.75
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M1",
    correlation = "exchangeable",
    complexity = "hard",
    mu = 0.5,
    sigma = 0.5
  ))
  
  # ---- N4M2 ----
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M2",
    correlation = "1dependent",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M2",
    correlation = "1dependent",
    complexity = "medium",
    mu = 0.5,
    sigma = 0.25
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M2",
    correlation = "1dependent",
    complexity = "hard",
    mu = 0.5,
    sigma = 0.1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M2",
    correlation = "dcp",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M2",
    correlation = "dcp",
    complexity = "medium",
    mu = 0.5,
    sigma = 0.25
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M2",
    correlation = "dcp",
    complexity = "hard",
    mu = 0.5,
    sigma = 0.1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M2",
    correlation = "exchangeable",
    complexity = "easy",
    mu = 0.5,
    sigma = 1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M2",
    correlation = "exchangeable",
    complexity = "medium",
    mu = 0.5,
    sigma = 0.5
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M2",
    correlation = "exchangeable",
    complexity = "hard",
    mu = 0.5,
    sigma = 0.1
  ))
  
  # ---- N4M3 ----
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4",
    correlation = "1dependent",
    complexity = "easy",
    mu = 0.8,
    sigma = 0.1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M3",
    correlation = "1dependent",
    complexity = "medium",
    mu = 0.6,
    sigma = 0.1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M3",
    correlation = "1dependent",
    complexity = "hard",
    mu = 0.5,
    sigma = 0.1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M3",
    correlation = "dcp",
    complexity = "easy",
    mu = 0.8,
    sigma = 0.1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M3",
    correlation = "dcp",
    complexity = "medium",
    mu = 0.6,
    sigma = 0.1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M3",
    correlation = "dcp",
    complexity = "hard",
    mu = 0.5,
    sigma = 0.1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M3",
    correlation = "exchangeable",
    complexity = "easy",
    mu = 0.8,
    sigma = 0.1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M3",
    correlation = "exchangeable",
    complexity = "medium",
    mu = 0.6,
    sigma = 0.1
  ))
  
  complexity_mapping <- rbind(complexity_mapping, data.frame(
    size = "N4M3",
    correlation = "exchangeable",
    complexity = "hard",
    mu = 0.5,
    sigma = 0.1
  ))
  
  return(complexity_mapping)
}
