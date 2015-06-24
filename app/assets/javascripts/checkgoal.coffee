draw_canvas = () ->
  c = $('canvas.overall-stat').get(0).getContext('2d')
  c.canvas.width = 200
  c.canvas.height = 200

  total_dates = $('canvas.overall-stat').attr('total-dates')
  today = Number($('canvas.overall-stat').attr('today'))
  verified_num_dates = JSON.parse($('canvas.overall-stat').attr('verified-num-dates'))

  radius = 75
  origin = [100, 100]
  stroke_start = [0, -radius]
  stroke_end = [0, -radius - 20]

  for num_date in [0..total_dates-1]
    color = "#CCC"
    if num_date in verified_num_dates
      color = "#40BD9C"
    else if num_date == today
      color = "#EA297D"
    else if num_date > today
      color = "#EEE"

    start = canvas_position(canvas_rot(stroke_start, num_date*360/total_dates), origin)
    end = canvas_position(canvas_rot(stroke_end, num_date*360/total_dates), origin)
    stroke_one(c, start, end, color, canvas_width(total_dates))

canvas_position = (p, offset) ->
  return [p[0] + offset[0], p[1] + offset[1]]

canvas_rot = (p, deg) ->
  rad = deg * Math.PI / 180
  return [Math.cos(rad) * p[0] - Math.sin(rad) * p[1], Math.sin(rad) * p[0] + Math.cos(rad) * p[1]]

canvas_width = (total_dates) ->
  if total_dates <= 15
    return 10
  else if total_dates <= 30
    return 8
  else if total_dates <= 45
    return 7
  else if total_dates <= 60
    return 6
  else if total_dates <= 75
    return 5
  else if total_dates <= 90
    return 4
  else
    return 3

stroke_one = (canvas, start, end, color, width) ->
  canvas.beginPath()
  canvas.lineWidth = width
  canvas.strokeStyle = color
  canvas.lineCap = "round"
  canvas.moveTo(start[0], start[1])
  canvas.lineTo(end[0], end[1])
  canvas.stroke()

$(document).on 'ready page:load', draw_canvas
