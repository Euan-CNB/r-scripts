# Load required libraries. Install if you haven't done so already
library(writexl)
library(priceR)

# List of non-AUD currencies to pull data for
foreign_fiat <- c("USD", "CAD", "GBP", "NZD", "EUR", "SGD")

# Set start and end dates here (format YYYY-mm-dd)

startDate <- "2020-08-01"
endDate <- "2022-03-14"

# Initial column for dates and AUD to AUD conversion
exchange_df <- historical_exchange_rates("AUD", to = "AUD", start_date = startDate, end_date = endDate)

# Loop over each non AUD FIAT currency
for(fiat in foreign_fiat){
  # Return each exchange rate for the period
  exchange_historical <- historical_exchange_rates(fiat, to = "AUD", start_date = startDate, end_date = endDate)
  
  # Add as a new column for the exchange rate dataframe
  exchange_df <- cbind(exchange_df, exchange_historical[,2])
}

# Name columns of Dataframe 
colnames(exchange_df) <- c("Date","AUD", foreign_fiat)

# Bounce to Excel

sheet_name <- paste("FX",Sys.Date(),".xlsx")
write_xlsx(exchange_df, sheet_name)