-- SOLUTIONS


-- A : Marketing Analysis
# Loyal User Reward
SELECT id, username, created_at FROM users
ORDER BY created_at
LIMIT 5;

# Inactive User Engagement 
SELECT * FROM users 
WHERE id NOT IN (
		SELECT user_id FROM photos
);

# Contest Winner Declaration
SELECT photos.id, users.username, COUNT(likes.user_id) AS total_likes
FROM photos
JOIN likes ON photos.id = likes.photo_id
JOIN users ON photos.user_id = users.id 
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1;

# Hashtag Research
SELECT tag_name, tag_id, COUNT(photo_id) as no_of_photo_tag 
FROM photo_tags
INNER JOIN tags
	ON photo_tags.tag_id = tags.id
GROUP BY tag_id
ORDER BY no_of_photo_tag DESC
LIMIT 5;

# Ad Campaign Launch
SELECT 
    DAYNAME(created_at) AS day_of_week, COUNT(id) AS user_count
FROM
    users
GROUP BY day_of_week
ORDER BY user_count DESC;


--  B : Investor Metrics
# User Engagement
SELECT 
	count(*) as total_post, 
	(SELECT count(*) from users) as total_users, 
	ROUND(count(*)/(SELECT count(*) from users),2) as avg_post_per_user
FROM photos;

# Bots & Fake Accounts
SELECT users.id, users.username
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING COUNT(likes.photo_id) = (SELECT COUNT(*) FROM photos);