
# ML-GB-BACKEND

[Url](https://mighty-fortress-18011.herokuapp.com/jobs/search?q=react)

This is the backend react app for the challenge of consuming a get on board job api. It has 3 endpoints, jobs/search(GET) for querying jobs that receives the query and user email, a favorite/create(POST) and favorite/delete (DELETE) that receive the job id and user.

### Deployment
Just use the normal steps to deploy to heroku, meaning heroku login, heroku create, git push heroku master, then `heroku run rake:db:migrate`

Note: For security while this exercise is evaluated, the backend for has the frontend herokU url hardcoded in CORS, so requests from another heroku app will fail. Later if this  repository is public the backend will allow any url or at least anything using heroku.

### View locally
`bundle install` , `rake db:create db:migrate` and `rails s`.

### Run the tests
`rspec spec.`

### FAQ (Rationale for technical decisions)

#### What's that service thing?
This is a 'mixin' module you can use for classes to use `execute` for initializing and return the results of an operation from the `execute` method.

#### Why 3 separate classes (search, decorate, fetch_jobs)?

This helps limiting resposabilities of each class, doing all of those in one class breaks single responsability principle way too much. Fetch_Jobs does the request to the get on board endpoint, decorate adds data from the user favorites to it, and search calls these two and adds a nice cache layer on the query term to avoid calling get on board endpoint for repeated terms. And hey, the search action in the controller ended up with only one line.

#### But these 3 classes aren't tested.
Similar response as the frontend, full unit testing wasn't required, and the controller+model specs with rspec + factory girl cover almost all paths as requested:
![ycKi0wt.png](https://i.imgur.com/ycKi0wt.png)

The calls to the get on board api are stubbed on the test environment.

### TODO's
These are some pending tasks I'd work on If I had more time, but I'd prefer not to risk turning this in way too late just to tackle this which weren't formally required.

- Use a proper cache setting on production, something like memcached would be faster but likely not part of the free tier on heroku.
- A real auth system.
