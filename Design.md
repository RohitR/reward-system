## Framework
There were plenty of options to select. Primary thought was to start with a rails. Since it is a light weight app decided to start with sinatra backed by a database. But the system really doesnt requires database. It is not holding data beteween requests, Hence finalised to begin with Rack.

This is a small rack based application where data stores in memory by a DSL.

## Solution 
Problem is to calculate reward gained by each customer upon successfule invitation. It is required to update values for ancestors also on each invitation. 
We can consider the entire system as a tree. Each customer will acts a node. Successful invitation connects beteween customers. So we can build a tree structure here. Now we can do a DFT (Depth first traversal) from root.
on each stage we need to backtrack to the parents recursively with associated calculation for points.

## Architecture
- Customer - Represents the node. It is having attributes name, parent , children and id. 
- Invitation - Invitation having properties
-- customer_id
-- friend_id
-- status
-- invited_at
- Repository - Acts as datastore. Having attributes customers and invites. This is a singleton class
- Db - It prepares the tree by filling customers and invites through the exposed method `Db.prepares(file)`
- RewardCalculator - Calculates scores by traversing and bactracking on the tree
- FileParser - Parses the file based on the regex. If not matches discarding the line.
- CommandValidator - Validates input commands. There are two child classes `Respond` and `Recommends` to handle validations based on inputs.
- Errors - All user defined exceptions are here