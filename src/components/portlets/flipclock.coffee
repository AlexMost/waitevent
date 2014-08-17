React = require 'react'
{div, script, label, span} = React.DOM


FlipClock = (args) ->
    div
        className: "text-center"
        dangerouslySetInnerHTML:
            __html: """
                <div class="clock text-center" style="margin:2em;"></div>
                <script type="text/javascript">
                    window.queue.push(function(){
                        var clock;
                        $(document).ready(function() {
                            var currentDate = new Date();
                            var futureDate  = new Date("#{args.target_date}");
                            var diff = (futureDate.getTime() / 1000 -
                                        currentDate.getTime() / 1000);

                            clock = $('.clock').FlipClock(diff, {
                                clockFace: 'DailyCounter',
                                countdown: true
                            });
                        });
                    });
                </script>
            """

module.exports = FlipClock