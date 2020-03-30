# View-model trees

In this article we will inspect the issues of flat state organization of a view model.

If you were to make a quick google for the following terms: MVC, MVP and MVVM, - and smashed `⌘-` a couple of times, an intriguining vision would emerge.
Turns out, our presentation layer, according to these graphs typically used for the representation, consists of just a single object that configures the view, a single object that represents a business-logic unit and a single object that represents the model layer of the architecture.
In real life, this is a very crude simplification and it has nothing to do with the reality.

## View trees

Simplest example of how such a graph is a tad misrepresentative of the real life is that there is only one view. 
(When I refer to the term view, I mean obviously not the view itself, but rather the object designated to configure the view. In real life, it is the view itself in some cases.) 
And in simple cases where the contents of the view itself are not determined dynamically this really is often true. 
The examples of screens that can have just a single view configuration object: pre-login screen. 1 label, "Welcome to the app", 2 buttons, "Sign in" and "Sign up". Overall appearance of the screen here doesn't depend on runtime conditions, it's not determined dynamically.

In this particular case - for sure, go on, there is no reason to overcomplicate things. 
In terms of UIKit, you might as well create, layout and populate with data all 3 widgets directly from the view controller. 
This would make you have a single "view" in MVC-alikes' terms - AKA a single object that configures all the view in this presentation stack.

This approach however becomes inconvenient when it get 2 new spins on it:

- The views are presented and modified dynamically, upon the directions of the business-logic unit
- The views include reusable components that are supposed to be operable with their own business logic from anywhere in the app

Let's figure out the second option first.

### Reusable views

Imagine I have a button, a reusable widget. 
And it's not really that bare in its functionality as appears initially. Its configurability includes:

- Button's title
- Whether or not it's in a "loading" state - the button features a spinner and when it shows it, it can't emit "tap" events
- Whether or not it's in a "locked" state - the button might represent some functionality behind a paywall and it displays it in a form of padlock icon, which also prevents it from emitting "tap" events

This functionality needs to be retained for all cases of the button's appearances. 
Obviously, needs go unstated - you definitely need to create a separate reusable object that has access to all these widgets inside the button and configures them accordingly and similarly every single time. 
This would allow you to establish a proper case of reusability, where you would plug this view into your own hierarchy, and provide it with a business logic unit that would comply with the interface that the widget expects.

This closely follows the philosophy of one of the concepts discussed in React's documentation. 
The concept is about the difference of a "Container Component" vs a "Presentation Component".

In React everything is a component. 
It doesn't typically have separate business logic objects.
The framework doesn't encourage a separate controller/presenter/viewmodel kind of object.
The framework encourages you to have 2 types of components.

The former is:
- "Presentation Component"
- a widget
- reusable
- no outside business logic
- dumb

The latter is:
- "Container Component"
- smart
- has business logic
- contains, composes and layouts the dumb ones
- interacts with the model layer of the app

This might appear highly reminiscent of Massive View Controler of AppKit/UIKit. 
I.e. no controller/presenter/vm, model interaction and business logic is written in the UIViewController.
Except, in React you use this thing when things become really complex. Usually not all React based GUI is written like this, it's often unnecessary, this segregation because the components might be simple enough and their layout might be simple enough so that segregation is simply overly verbose and unnecessary. 
But in iOS, it's just that configuring our views usually takes a lot of hassle and in Massive View Controller it's also that devs don't bother to propely introduce dumb views, making the view controller configure literally everything down to the smallest details.

Well, that button, with a "loading" state and a "locked" state is a great example of the "dumb" view. It:

- is composable and reusable
- provides an interface for the business logic to interact with the view

Come to think of it, even Massive View Controller would benefit if we would only encapsulate the configuration of it's widgets into separate UIView subclasses.

### Dynamically configured views

And then you have cases where configuring everything out of a single place will be inconvenient because of the degree of dynamism dictated by the software requirements.

Dig this, this is an example that I remember from 3 years ago when I googled something about the XAML layout capabilities in Xamarin.Forms, talk about dead technologies, am I right? There, it was a stack overflow question. The guy was wondering how can he layout a collection view so that it features collection views as its cells. So essentially, model-wise it's an array of arrays of some data to place into inner cells.

Also, let's put another spin on it - the collection views inside the main big one can have different layouts, they can be fed with data of different formats. Also, let's complicate it even more - add a scroll view, and it has 2 more scroll views inside and a neutral view between and there is a dynamic behavior that switches out the scrolls depending on the outer scroll view.

Given this, now let's ask us a question: is it really necessary to see in the same scope both the second scroll view inside the big scroll view and the array of completely unrelated collection views inside the completely unrelated collection view? 
You know these long multiline `viewDidLoad` implementations where it's purely constraints instantiation and configuration for 100 lines?

I'm given a task to add a help button to a screen of exactly this complexity. 
It's a Material design's floating action button, a UX absolutely non-native to iOS, fucking crammed in from Android by the dear designer. And it has absolutely nothing to do with:

- Any of the shitty scroll views
- Any of the collection views
- Literally anything else in this view controller

So how comes, the object that configures all of that garbage should also be concerned with this FAB at the bottom right corner? And the answer is...

Look, I was really trying to make is all so revelatory and contrived, but now that I've already nagged about the reusability and dumbness of views, I don't think there is much fuss to be made about the fact that it's simply too much code! 
We already assemble the views into hierarchies to render them.
It also makes sense to assemble the objects that *configure* them into hierarchies too. 
Otherwise, in the same scope you will know about top-layer FAB and a collection view cell neighboring 16 subviews below.

## Flat view-model

Alright, with importance of view trees established, let's talk business logic units. I did name this section "flat view-model", but by this i obviously mean literally any business logic unit you can come up with - controllers, presenters, etc. I will however be using the cases of MVVM stack for demonstration.

