import pycountry

# Function to get a list of country names using python pacakges
def get_country_names():
    countries = list(pycountry.countries)
    country_names = [country.name for country in countries]
    return country_names

# Function to count country frequency in a string variable 
def count_country_occurrences(input_string, country_names):
    country_counts = {}
    for country_name in country_names:
        count = input_string.lower().count(country_name.lower())
        if count > 0:
            country_counts[country_name] = count
    return country_counts

if __name__ == "__main__":
    # Specify the path to the uploaded text file
    file_path = '/content/slr3.txt'

    with open(file_path, "r") as file:
        input_string = file.read()

    country_names = get_country_names()
    country_counts = count_country_occurrences(input_string, country_names)

    for country, count in country_counts.items():
        print(f"{country}: {count} occurrence(s)")
