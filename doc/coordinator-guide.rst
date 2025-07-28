.. _coordinator-guide:

*****************
Coordinator guide
*****************

What is an Instance Coordinator
===============================

An instance coordinator helps manage the users in an instance. For example, they may add and remove users from different teams, and help to implement exit strategies for users and data. More information about the utility of this role and helpful strategies will be added soon!

Training sessions
=================

As an instance coordinator, it is a good idea to organize training sessions for users. You can either opt for Deltablot's training session or make one yourself. It can also just be a discussion with users about their use of the software and the difficulties they might have with it and how to adress them.

Internal exchange
=================

In order to help users, we recommend making available a place for everyone to exchange on eLabFTW. It could be a Slack/Teams/Mattermost channel, or a forum or anything else that is easy to access for everyone involved. They can use this place to ask questions directly to the coordinator.


Different strategies for managing users in teams
================================================

When a user leaves a team
-------------------------

In eLabFTW, there are currently several options for handling the data of users who are about to leave a team. Here are four exit strategies to consider:

A. Archiving the user and their entries
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


If a person is only a member of one team, they can be archived. In this process, it's possible to choose whether their associated entries should also be locked and archived. This method ensures a clean separation, but it is only suitable if the person belongs to a single team. If the person is active in multiple teams, archiving them would also archive them in the other teams, which is usually not desired.

B. Adjusting visibility and write permissions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Another exit strategy involves explicitly setting the visibility and write permissions of the entries for the team the person is leaving. To ensure that the entries remain visible to the team after the user’s departure, the corresponding permissions for all entries need to be updated. This can be done by a team admin as a bulk action through the admin control panel. This way, the team retains access to experiments and entries without the person remaining part of the team.

C. Transferring ownership or duplicating entries
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Another option is to transfer ownership of the entries to another team member. Alternatively, relevant entries can be duplicated before the person is removed from the team. Once a person is removed from the team, their entries are no longer visible to the team, which also means that the original ownership becomes unclear. To avoid this, the name of the original creator can be added to the entry title or stored as a tag to make the data origin more transparent.

D. Restricting the visibility of entries
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Instead of removing the person from the team, they can remain a member while limiting the visibility of their entries. Access rights can be managed so that only the original owner and admins have access to certain entries. This ensures that the person leaving the team cannot access information irrelevant to them, while still technically remaining in the team.
