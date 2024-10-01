// server.js
const express = require('express');
const bodyParser = require('body-parser');
const routes = require('./routes/index');
const app = express();
app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.use('/classroom',  require('./routes/classroom') );
app.use('/classroom_types', require('./routes/classroom_types'));
app.use('/department', require('./routes/department'));
app.use('/subject', require('./routes/subject'));
app.use('/guardian', require('./routes/guardian'));
app.use('/guardian_type', require('./routes/guardian_type'));
app.use('/student', require('./routes/student'));
app.use('/student_guardian', require('./routes/student_guardian'));
app.use('/teacher', require('./routes/teacher'));
app.use('/school_year', require('./routes/school_year'));
app.use('/year_level', require('./routes/year_level'));
app.use('/student_year_level', require('./routes/student_year_level'));
app.use('/term', require('./routes/term'));
app.use('/period', require('./routes/period'));
app.use('/class', require('./routes/class'));
app.use('/student_class', require('./routes/student_class'));

// Home route
app.get('/', (req, res) => {
  res.render('index');  // Assumes you have index.ejs in the views folder
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

