Feature: Manage homepages
  In order to generate interest in the posts
  the blogger
  wants to have all the expected functionality on the homepage

  Background:
    Given the following posts:
      | title       | content             | published | published_at |
      | First Post  | First post content  | true      | 2011-08-5    |
      | Second Post | Second post content | true      | 2011-08-10   |
      | Third Post  | Third post content  | true      | 2011-08-1    |
      | Fourth Post | Fourth post content | false     | nil          |

  Scenario: Posts should be displayed in reverse order by published date
    Given I am on the homepage
    Then post 1 should be titled "Second Post"
    And post 2 should be titled "First Post"
    And post 3 should be titled "Third Post"
    And I should not see "Fourth Post"

  Scenario: I read an individual post
    Given I am on the homepage
    And I follow "First Post"
    Then I should see "First Post" within "h2"
    And I should see "First post content"