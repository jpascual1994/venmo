# Users
user1 = User.find_or_create_by!(name: 'John', email: 'john@example.com')
user2 = User.find_or_create_by!(name: 'Susan', email: 'susan@example.com')
user3 = User.find_or_create_by!(name: 'James', email: 'james@example.com')
user4 = User.find_or_create_by!(name: 'Sarah', email: 'sarah@example.com')
user5 = User.find_or_create_by!(name: 'Carl', email: 'carl@example.com')
user6 = User.find_or_create_by!(name: 'Lisa', email: 'lisa@example.com')

# Balances
user1.account.update!(balance: 500)
user2.account.update!(balance: 600)
user3.account.update!(balance: 50)
user4.account.update!(balance: 900)
user5.account.update!(balance: 1200)
user6.account.update!(balance: 0)

# Friendships
Friendship.find_or_create_by!(user_a: user1, user_b: user2)
Friendship.find_or_create_by!(user_a: user1, user_b: user3)
Friendship.find_or_create_by!(user_a: user2, user_b: user4)
Friendship.find_or_create_by!(user_a: user2, user_b: user3)
Friendship.find_or_create_by!(user_a: user3, user_b: user4)
Friendship.find_or_create_by!(user_a: user4, user_b: user5)

# Payments
Payment.find_or_create_by!(sender: user1, receiver: user2, amount: 100, description: 'Dinner')
Payment.find_or_create_by!(sender: user2, receiver: user3, amount: 50, description: 'Pay back')
Payment.find_or_create_by!(sender: user3, receiver: user1, amount: 70, description: 'Today beers')
Payment.find_or_create_by!(sender: user2, receiver: user4, amount: 200, description: 'Gift')
Payment.find_or_create_by!(sender: user4, receiver: user5, amount: 500, description: 'Happy Bday')
