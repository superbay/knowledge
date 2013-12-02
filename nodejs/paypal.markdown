Node.js at PayPal
POSTED ON NOVEMBER 22, 2013 BY JEFF HARRELL


inShare
184

There’s been a lot of talk on PayPal moving to node.js for an application platform. As a continuation from part 1 of Set My UI Free, I’m happy to say that the rumors are true and our web applications are moving away from Java and onto JavaScript and node.js.

Historically, our engineering teams have been segmented into those who code for the browser (using HTML, CSS and JavaScript) and those who code for the application layer (using Java). Imagine an HTML developer who has to ask a Java developer to link together page “A” and “B”. That’s where we were. This model has fallen behind with the introduction of full-stack engineers, those capable of creating an awesome user interface and then building the application backing it. Call them unicorns, but that’s what we want and the primary blocker at PayPal has always been the artificial boundary we established between the browser and server.

Node.js helps us solve this by enabling both the browser and server applications to be written in JavaScript. It unifies our engineering specialties into one team which allows us to understand and react to our users’ needs at any level in the technology stack.

Early adoption

Like many others, we slipped node.js in the door as a prototyping platform. Also like many others, it proved extremely proficient and we decided to give it a go on production.

Our initial attempts used express for routing, nconf for configuration, and grunt for build tasks. We especially liked the ubiquity of express, but found it didn’t scale well in multiple development teams. Express is non-prescriptive and allows you to set up a server in whatever way you see fit. This is great for flexibility, but bad for consistency in large teams. Over time we saw patterns emerge as more teams picked up node.js and turned those into Kraken.js; it’s not a framework in itself, but a convention layer on top of express that allows it to scale to larger development organizations. We wanted our engineers to focus on building their applications and not just focus on setting up their environments.

We’ve been using kraken.js internally for many months now (we’ll be open sourcing it soon!) and our engineering teams are eager to finally bring the internal node.js applications we’ve built live.

Bringing node.js to production

Our first adopter of node.js in production wasn’t a minor application; it was our account overview page and one of the most trafficked apps on the website. We decided to go big, but we also mitigated that risk by building the equivalent Java application in parallel. We knew how to deploy and scale Java applications, so if anything went wrong with the node.js app, we could fall back to the Java one. This provided the setting for some interesting data.

Development

We started in January and it took us a few months to get the necessary infrastructure in place for node.js to work in PayPal, e.g. sessions, centralized logging, keystores. During this time we had five engineers working on the Java application. Two months in to the Java development, two engineers started working on the parallel node.js app. In early June they met at a crossroads, the applications had the same set of functionality; the node.js application, a smaller team with a two month delayed start, had quickly caught up. A few details stood out after we ran the test cases and both applications passed the same functional tests. The node.js app was:

Built almost twice as fast with fewer people
Written in 33% fewer lines of code
Constructed with 40% fewer files
This provided encouraging evidence to show that our teams could move faster with JavaScript. We were sold and made the decision to put the Java app on hold while we doubled down on the JavaScript one. The great news is that the Java engineers on the project, unsure about node.js in the beginning, delightfully moved over to node.js and are happily committing to a parallel work stream, providing us with double the productivity we were originally seeing.

Performance

Performance is a fun and debatable topic. In our case, we had two applications with the exact same functionality and built by roughly the same teams: one on our internal Java framework based on Spring and the other built on kraken.js using express, dust.js and other open source code. The application contained three routes and each route made a between two and five API requests, orchestrated the data and rendered the page using Dust.

We ran our test suite using production hardware that tested the routes and collected data on throughput and response time.



You can see that the node.js application had:

Double the requests per second vs. the Java application. This is even more interesting because our initial performance results were using a single core for the node.js application compared to five cores in Java. We expect to increase this divide further.
35% decrease in the average response time for the same page. This resulted in the pages being served 200ms faster— something users will definitely notice.
There’s a disclaimer attached to this data: this is with our frameworks and two of our applications. It’s just about as apples-to-apples a performance test as we could get between technologies, but your milage may vary. That said, we’re excited by what we’ve seen from node.js’ raw performance.

Future

All of our consumer facing web applications going forward will be built on node.js. Some, like our developer portal, are already live while others, like account overview, are in beta There are over a dozen apps already in some stage of this migration and we will continue to share data as more applications go live. This is an exciting time for engineering at PayPal!

– Jeff Harrell
@juxtajeff
