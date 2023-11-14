# OnTrack

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

This app is essentially your all-in-one space to keep track of homework assignments/projects, exams, and quick notes for each of the classes you are  currently taking.

### App Evaluation

- **Category:** Productivity
- **Mobile:** As much as this could just as easily be a website, it makes it more convenient for users to be able to access these features from the convenience of their palm, especially as a college student who could be more likely to be with their phone than their computer, especially if they need to be reminded about an outstanding task while hanging out with friends.
- **Story:** Students are able to stay up-to-date with all their classes, ensuring that nothing is left outstanding. Considering how beneficial this would be to students, the audience of this app is able to see value in essentially having a mobile and digital accountability partner for school work.
- **Market:** This would appeal mostly to students generally but my ideal target audience is fellow college stduents like myself. In some sense, this may only realistically appeal to studious students who do not want to miss deadlines, but it is ultimately for any student regardless of level of education.
- **Habit:** Considering that is essentially a school planner, the user would likely use the app often, so that they would always be on track with all their work. The app would probably be opened many times in one day to either check what tasks need to be done or to add/edit existing tasks.
- **Scope:** The app in some sense should not be too complicated, at the very most the optional features such as adding the ability of the app to push notification reminders about outstanding tasks. The app realistically just works with switching between view controllers using tab bar navigation, so it terms of technically challenging, it should be very possible to complete it by the end of the program.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [x] User can add homework as new tasks
* [ ] User can toggle completed/unfinished for homeworks/projects
* [x] User can add exams as events to keep track of exam dates
* [x] User can delete homework tasks


**Optional Nice-to-have Stories**

* [ ] User can receive reminder notifications about outstanding tasks
* [ ] User can change some settings of the app, such as frequency of notifications or color theme
* [ ] User can view all tasks in a calendar view
* [ ] User can view a list of their classes
* [ ] User can view a detailed view of each course they are taking

### 2. Screen Archetypes

- [x] Stream
* User can toggle completed/unfinished for homeworks/projects
* User can delete homework tasks
- [x] Creation
* User can add homework as new tasks
* User can add exams as events to keep track of exam dates
- [ ] Calendar **(Optional)**
* User can view all tasks in a calendar view

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Homework Todo List
* Exam Countdown
* Calendar View

**Flow Navigation** (Screen to Screen)

- [x] Stream
* Creation, for the creation of new tasks/exam date events that will appear in the stream screen
* Future version will likely involve navigation to a detailed view of courses, if [Courses Overview] tab navigation is added
- [x] Creation
* Stream, returns back to this screen after creating a new task/exam date event
- [ ] Calendar
* None

## Wireframes

<img src="https://github.com/fiyinfoluwaafol/iOS-Capstone-Project/assets/112602670/7b1e61ec-5e94-433b-8587-05af1f32f8bb" width=600>

## Progress Update
Since the last status update, I have been able to complete the core features of the app, and was able to get started working on the optional calendar view. Ultimately, I also plan to
implement notifications about upcoming exams and homework deadlines. I unfortunately ran into a slight issue with editing an already existing homework/exam, it created it as a new
cell rather than just updating it in the table view.
<div>
    <a href="https://www.loom.com/share/d56a3b04b2b44405b914aea25c833e83">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/d56a3b04b2b44405b914aea25c833e83-with-play.gif">
    </a>
  </div>
