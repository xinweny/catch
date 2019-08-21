import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!

flatpickr(".datepicker_start", { allowInput: true, enableTime: true, minDate: 'today' })
flatpickr(".datepicker_end", { allowInput: true, enableTime: true, minDate: 'today' })
