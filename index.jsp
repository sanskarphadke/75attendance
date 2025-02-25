<html>
<head>
    <title>Attendance Calculator</title>
    <style>
        * { font-size: 30px; font-family: Cambria; }
        body { background-color: #88B04B; }
        input, select { width: 200px; height: 40px; font-size: 30px; }
        h1 { font-size: 60px; color: white; }
    </style>
</head>
<body>
    <center>
        <h1>Attendance Calculator App by Sanskar</h1>
        <p style="font-size:20px">Find out the number of days you can bunk while still maintaining 75% attendance. &#x1F60E; </p>
        <form method="post">
            <br/>
            Percentage required:
            <select name="percent">
                <option value="60">60%</option>
                <option value="70">70%</option>
                <option value="75" selected>75%</option>
                <option value="80">80%</option>
                <option value="85">85%</option>
                <option value="90">90%</option>
            </select>
            <br/><br/>
            Lectures Attended:
            <input type="number" name="la" min="0" required>
            <br/><br/>
            Total Lectures:
            <input type="number" name="tl" min="1" required>
            <br/><br/>
            <input type="submit" name="btn" value="Calculate"/>
        </form>

        <%
        if(request.getParameter("btn") != null) {
            try {
                int present = Integer.parseInt(request.getParameter("la"));
                int total = Integer.parseInt(request.getParameter("tl"));
                int requiredPercentage = Integer.parseInt(request.getParameter("percent"));

                if (present < 0 || total < 1) {
                    out.println("<span style='color:red;'>Invalid input. Values must be positive.</span>");
                } else if (present > total) {
                    out.println("<span style='color:red;'>Error: Attended lectures cannot be greater than total lectures.</span>");
                } else {
                    float currentAttendance = ((float) present / total) * 100;
                    int minRequiredLectures = (int) Math.ceil((requiredPercentage / 100.0) * (total + 1));

                    if (present < minRequiredLectures) {
                        int additionalLectures = minRequiredLectures - present;
                        out.println("You need to attend <b>" + additionalLectures + "</b> more classes to maintain " + requiredPercentage + "% attendance.<br>");
                    } else {
                        int maxBunkableLectures = 0;
                        while (((float) present / (total + maxBunkableLectures)) * 100 >= requiredPercentage) {
                            maxBunkableLectures++;
                        }
                        maxBunkableLectures--; // Correct the final count

                        out.println("You can bunk <b>" + maxBunkableLectures + "</b> more lectures while maintaining " + requiredPercentage + "% attendance.<br>");
                    }
                    out.println("<br><b>Current Attendance:</b> " + present + "/" + total + " -> " + String.format("%.2f", currentAttendance) + "%");
                }
            } catch (NumberFormatException e) {
                out.println("<span style='color:red;'>Error: Enter valid integer values.</span>");
            }
        }
        %>
    </center>
</body>
</html>
