```html
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="ie6 no-js light_layout" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="ie7 no-js light_layout" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="ie8 no-js light_layout" lang="en"> <![endif]-->
<html lang='en'>
    <head>
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src='http://malsup.github.io/jquery.blockUI.js'></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script>
            $(document).ready(function() { 
                //$.blockUI(); 
                //$('.blockOverlay').attr('title','Click to unblock').click($.unblockUI); 
            }); 
        </script>
        <meta http-equiv='refresh' content='1000; url=http://github.com/'>
        <title>Title</title>
        <style type="text/css">
            body {
                background-image:url('bg.png');
                background-repeat:no-repeat;
                background-attachment:fixed;
                background-position:center top;
                margin: 0;
            }
            #overlayer {
                width: 100%;
                height: 100%;
                background: #000;
                opacity: 0.7;
                position: fixed;
            }

            #dialog {
                font: 0.9em helvetica,arial,clean,sans-serif;
                margin: auto;
                padding: 1em;
                width: 400px;
                height: 125px;
                display: block;
                background: #fff;
                z-index: 9999;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                border: solid 0.8em;
                border-color: #000;
                border-color: rgba(0, 0, 0, .3);
                background-clip: padding-box;
                -moz-background-clip: padding-box;
                -webkit-background-clip: padding-box;
                -ms-background-clip: padding-box;
                
            }

            #dialog p:first-child {
                margin: 0;
            }

            #dialog a {
                color: #668894;
                text-decoration: none;
            }

            #dialog a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
      <body>
          <div id='overlayer'></div>
          <div id='dialog'>
            <p>Here you go.</p>
            <p>Please visit <a href='http://www.github.com'>Github</a>. </p>
            <p>You will be redirected to <a href='http://www.github.com'>github</a> in 5 seconds.</p>
          </div>
      </body>
</html>

```
