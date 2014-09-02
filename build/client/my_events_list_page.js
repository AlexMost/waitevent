var MyEventsListPage, React, componentData, mountNode;

React = require('react');

MyEventsListPage = require('../components/my_events_list_page');

mountNode = document.getElementById("react-main-mount");

componentData = JSON.parse((document.getElementById("componentData")).innerHTML);

React.renderComponent(new MyEventsListPage(componentData), mountNode);
