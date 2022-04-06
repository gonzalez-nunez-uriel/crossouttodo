# Strategy

## Purpose

This web application is just practice. Todo app is my personal kata. The app is going to have users, but no user registration. The users are going to be created when the tables are created during migrations. The user is going to have a main dashboard were it can view todo items. It can create items. It can delete items. It can mark them complete. It can also view the history of all the tasks that it has completed. The undo feature is going to be implemented last and is intended as a challenge; expect for it not to work.

The app has a log file where unusual events are recorded. This is done for debugging purposes.

## Schemas

### Sessions

* session: string
* user_id: user reference


### Users

* name: string
* username: string
* password: string


### Taks

* name: string, required
* summary: string, required
* description: text
* deadline: datetime
* date_completed: datetime
* completed: boolean, default false

#### Constraints
* date_completed must be null if completed is false.
* in the event that the undo action is performed, the date_completed must be set back to null.


## Routes

### GET /
are aliases a good idea? No. Ignore, but keep here as a lesson
#### alias GET /index; GET /index.html

#### Properties
Rendering

A static welcome page, consisting of two panels: 1) a description panel and 2) a login form. The description panel must be on the left side of the page and the login form to the left. This landing page should not scroll; it should take up all the space (centered). The description panel should be bigger than the login form, something like 3/4 description panel and 1/4 login panel, but with a more appealing ratio - you could approximate using the golden ratio.

For the login form, it should make **POST /login**.


### GET /faq

#### Properties
Static html

Renders a list of FAQs.


### POST /login

#### Properties
Non-rendering page.

This page authenticates the credentials given by the user. 

If the credentials are correct, it creates a session, sets a session cookie, and redirects to **GET /dashboard**.

If the credentials are wrong, it redirects to **GET /error/wrong-credentials**.


#### GET /dashboard

#### Properties
Requires a session cookie, hits tables Users and Tasks.

This page requires a session cookie. If a session cookie is not present, redirect to GET /error/no-session.


The page consists of a control pane and a task pane.

##### Control Pane

This pane contains information about the user as well as controls needed to do actions with the web app. This pane is composed of a user pane and an actions pane. The user pane is composed of a user profile picture area, the name of the user, and the username. For more information, see wf-control-pane and wf-dashboard. The actions supported are: 'new', 'undo', and 'frequently asked questions'. These actios are displayed as buttons. The new button should be wrapped with an anchor and it should direct to **GET /dashboard/new**. Undo should submit an empty form to **POST /dashboard/undo**. This will undo the last change made in the last 10 mins. Changes older than 10 mins must be undone using the controls provided in **GET /dashboard/history**. The 'freqnetly asked questions' link should point to a page explaining some behaviors of the app, like the undo feature only taking effect for tasks marked completed in the last 10 mins; and explain that this prevents the user accidentally brining too much stuff by accident.

##### Task Pane

This pane contains the tasks the user needs to complete displayed in a table. The task pane is composed of a table displaying individual tasks. This table must have headers. Each row of this table will belong to a task class for styling. Each row is composed of task name, task summary, a link to a detailed description of the task, deadline, a 'mark completed' button and a delete button; each corresponding to the relevant information for each task (if appropiate). The anchor previously mentioned needs to display the text: "read more". The mark completed and the delete buttons are submit buttons for hidden forms that contains all the information needed to mark completed or delete the task. This information consists simply of the task id and it is sent to **POST /dashboard/completed** and **POST /dashboard/delete** , respectively. For more information, see wf-task-pane and wf-dashboard.

The "read more" link points to **GET /dashboard/tasks/:id**, where the :id is generated during rendering. 

For more information, see wf-task-pane.

#### Concerns
How do you handle expired sessions? Does there needs to be a server worker or something that checks this every now and then?


### GET /dashboard/new

#### Properties
Uses url params

Renders form to create a new task. The form should make **POST /dashboard/new**

#### SP CASE: returning from a bad-task error
In the event that the user is redirected to this node from **GET /error/bad-task**, then the information from the bad task is going to be sent as parameters and it needs to be included in the rendering of this page. This is to spare the user from starting from scratch in the event that it made a mistake.


## POST /dashboard/new

#### Properties
Requires session cookie

Handles the insertion of a new task to the database. The controller needs to enforce the required fields. If the form is not proper, send to **GET /error/bad-task**.


### POST /dashboard/undo

#### Properties
Non-rendering

If the latest completed task is within 10 minutes of the current time, change completed to FALSE and date_completed to NULL.


### POST /dashboard/completed

#### Properties
Uses body, requires session cookie

If task id is not found, send to error **GET /error/task-not-found**. Since this is sent through hidden fomrs, this incident is not an error on the user, but rather a bug in the web app. This incident needs to be logged.

This controller sets the completed property of tasks from FALSE to TRUE.


### POST /dashboard/delete

#### Properties
Uses body, requires session cookie

This controller deletes the indicated task, if it exists. If task id is not found, send to error **GET /error/task-not-found**. Since this is sent through hidden fomrs, this incident is not an error on the user, but rather a bug in the web app. This incident needs to be logged.

This action cannot be undone. This must be indicated in the FAQ.

### GET /dashboard/history

#### Properties
Hits the Users and Tasks tables, requires session cookie

This shows all the tasks for the given user that are marked as completed. Just like the 

For more information, see wf-history


### GET /dashboard/task/:id

Needs to render the task id for the user to reference/store/use. Once a task is complete, it is read only and shows the date of completion.

This also must not allow the user to access an id that it has no authorization to accesss. A clever user can input any id and access the task of someone else. If this happens, redirect to **GET /error/not-authorized**.


## Error Routes

All error routes use url params if they are rendered by the server. Do not, under any circumstance, send user credentials over a url. If requested in the documentation, please contact architect because this is a mistake.

### GET /error/wrong-credentials

#### Properties
Static html

Page that explains to the user that the credentials submitted in a login form are incorrect. The page should indicate the user ways to troubleshoot the error, alternatives, and who to contact for help.


### GET /error/not-authorized

#### Properties
Static html

Rendered when the user tries to access a reasource that is not allowed to access; most likely a task that does not belong to it. Explain to the user that this resource does not beong to the user and what options it has to move forward.


### GET /error/no-session

#### Properties
Static html

Page that explains to the user that no session cookie was found. Explain to the user what a session cookie is, how it is used, and that to get one it must log in.


### GET /error/task-not-found

#### Properties
Dynamic html, url params

Displays the id of a task that the user attempted to perform an operation on, but the task is missing. It explains to the user that the task is missing and what are its options. With the exception of **GET /dashboard/task/:id** with some artbitrarily given :id, this is not normal, this means there is some sort of bug in the web app. This incident needs to be reported.


### GET /error/bad-task

#### Properties
Dynamic html, url params

Page that explains to the user that some information is missing or not properly formatted. This information needs to be pertinent to the task just submitted.

It should display a return to task option, which redirects to **GET /dashboard/new** with the value of the forms as params. Is this possible, even if the description is long? HTTP being stateless is really bad for desig of this thing. How do I save the information of the form so that the user does not have to start over if it made a mistake?


## Strategy

### Stage 1, the database

As usual, it is best to start from the database and move into the front end. Start with the user databse since it depends on nothing and others depend on it. Then go with the sessions database. Make the dependency between the sessions and the users. Then do the tasks, then mark the dependency to the users. Use the todo app as template to achieve this. Test whether everything is working using the rails console. After that, reset the database and run a seed that creates all users and their passwords.

At this point, you should have all models working

### Stage 2, landing page

Naturally, start with index.html. It is simple. Then go with the FAQ. This one will be populated as indicated in the other routes. Then proceed with all the error pages.

At this point, you should have the landing page all ready, the FAQ initial template ready, and have all the static error pages.

### Stage 3, dashbaord

Using the rails console, add some tasks to the user Uriel. Now proceed to create the dashboard controller and view as follows:
1. Create a view with only the control pane. Leave all buttons inactive
1. Create an empty task pane
1. Create the logic to render the names of each task
1. Create the logic to render the task as indicated in the docs leaving the buttons inactive

At this point you should have all the dashboard view/aesthetics complete. The dashbhoard should be able to read existing tasks from a user.

### Stage 4, Details

Create a new controller to see the details of a task. The route is **GET /dashboard/task/:id**. You can name the controller Detail or something; idk. Implement the anchor 'see more' and make sure the routing is correct. Then create a view to see the task. Include the 'Edit' anb mark complete buttons but leave it inactive.

At this point you should be able to see the complete details of a task without being ap=ble to edit it or marking it complete.

### Stage 5, psoting a new task
now create the **GET /dashboard/new** controller and view. Implement the 'new' button in the control pane in **/dashboard** using an anchor tag with a button, referencing the new view. This vierw can be left empty; add debug code of your choice to make sure everything is working properly. Then implement the **/dashboard/new** form to create a new task. Please mark the required fields. Leave the submit button inactive.

At this point the view for the dashboard should be complete.

### Stage 6, inserting a new task

Create the **POST /dashboard/new** controller. This does not have a view; which means that you have to make sure you use a redirect to **GET /dashboard**, which should request an updated version of the page, reflecting the change. Make sure to soft-enforce all required fields.

This reminds me that last time the db did not enforce the required fields, so you need to double check that.

At this point, the user should be able to add new tasks.

### Stage 7, deleting a task

This stage is about implementing the 'delete' button for each task. This button is implemented using a hidden form with the information needed to delete the task. Namely its id. There must be some sort of safeguard preventing nonauthorized users from deleting a task they do not own.

### Stage 8, mark a task completed

### Stage 9, view history

### Stage 10, history undo action




