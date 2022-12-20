-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT cf_id,backers_count
FROM campaign 
WHERE outcome='live'
ORDER BY backers_count DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT b.cf_id, COUNT(b.backer_id) as backers_count
FROM backers as b
LEFT JOIN campaign as c
ON b.cf_id=c.cf_id
WHERE c.outcome='live'
GROUP BY b.cf_id
ORDER BY COUNT(b.backer_id) DESC;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT ct.first_name, ct.last_name, ct.email, (c.goal-c.pledged) as amount_left_to_goal
INTO email_contacts_remaining_goal_amount
FROM campaign as c
LEFT JOIN contacts as ct
ON ct.contact_id=c.contact_id
WHERE c.outcome='live'
ORDER BY (c.goal-c.pledged) DESC;


-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT b.email, b.first_name, b.last_name, b.cf_id, c.company_name, c.description, c.end_date, (c.goal-c.pledged) as "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers as b
RIGHT JOIN campaign as c
ON b.cf_id=c.cf_id
WHERE c.outcome='live'
ORDER BY b.email DESC;


