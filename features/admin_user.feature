Feature: Admin users
  In order to manage the blog
  an administrator
  should be able to log in and operate the site

  Background:
    Given the following users exist:
      | name          | email             | password | about                |
      | Drake Mallard | admin@example.com | password | I am a meat popsicle |

  Scenario: Admin user signs in
    When  I am on the admin dashboard
    And I fill in "Email" with "admin@example.com"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should see "Welcome Drake Mallard"
