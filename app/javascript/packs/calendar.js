import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from "@fullcalendar/list";

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');
  if (!calendarEl) return;

  var calendar = new Calendar(calendarEl, {
    plugins: [dayGridPlugin, listPlugin],
    initialView: 'dayGridMonth',
    locale: "jp",
    events: '/calendars.json',
    windowResize: function () { 
      if (window.innerWidth < 991.98) {
          calendar.changeView('listMonth');
      } else {
          calendar.changeView('dayGridMonth');
      }
    },

    eventClick: function(info) {
      if (!info.event.extendedProps.editable) {
        alert("自分の投稿のみ削除できます");
        return;
      }

      if (!confirm("この行事を削除しますか？")) {
        return;
      }
    
      fetch(`/calendars/${info.event.id}`, {
        method: "DELETE",
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        }
      }).then(() => {
        info.event.remove(); // 画面からも削除
      });
    },
  });

  calendar.render();
});