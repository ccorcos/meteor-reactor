# Meteor-React Leaderboard Demo

Based on [Pete Hunt's Devshop Talk](https://www.youtube.com/watch?v=qqVbr_LaCIo) and [demo](https://github.com/petehunt/react-meteor-preso/tree/step6).

React is pretty cool -- it allows you to build everything from Javascript if you want, including css. The reconcilliation algorithm is incredibly fast which is the workhorse behind react. That said, the it scares me to have one huge autorun in the the entire appliction like this, especially as it gets bigger. 

Some thoughts:

- You may be able to use Autorun at the component level if you only fetch Player._id's, then you could fetch the entire player object in setInitialState within an autorun. This way, the React only has to re-render the template who's state changes. However, if we add a new player, will it attempt to re-render everything all over again? Well, reconcilliation should notice the reused _id's and not re-render those. Maybe we could go a step further and use the pure mixin to imporve performance. Not 100% sure what that does though.

To do:
- See if setState autorun works. Check what react re-renders. What happens when you inc a score?
- What if we put selected inside an autorun as well in the state. That should work.
- What are the performance trade-offs here? Does an app end up becoming one giant component with one giant state?
- When to use autorun on state vs global props?

- Make functions for creating Ionic UI components?
- Observable streams for UI event handling would be nice - make a side menu!

- fork iron router so we can route without template --  how to animate between routes? integrate with velocity
- meteor without blaze!
- rewrite the taxes app with react.