Feature: Map Controller functionality

  Background:
     Given the following states exist:
    | symbol | name        | fips_code | is_territory | lat_min     | lat_max     | long_min    | long_max    |
    | NY     | New York    | 36        | 0            | -79.762152  | -71.856214  | 40.496103   | -71.856214  |
    | CA     | California  | 06        | 0            | -124.409591 | -114.131211 | 32.534156   | -114.131211 |

  Scenario: View the map of the United States
    When I visit the map index page

  Scenario: View the map of a specific state
    When I visit the state map page for "NY"

