import $ from "jquery";

import { indexTasks, postTask } from "./requests.js";

function getTasks() {
  indexTasks(function (response) {
    var htmlString = response.tasks.map(function (task) {
      return (
        "<div class='col-12 mb-3 p-2 border rounded task' data-id='" +
        task.id +
        "'> \
        " +
        task.content +
        "\
        </div>"
      );
    });
  
    $("#tasks").html(htmlString);
  });
}

function createTask(value) {
  console.log(value);

  // use postTask()
}

// document ready
$(function () {
  console.log("document ready");
  getTasks();

  $("#task-form").on("submit", function (event) {
    event.preventDefault();
    
    const value = $("#task-input").val();
    createTask(value);
  });
});
