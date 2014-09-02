var SetIntervalMixin;

SetIntervalMixin = {
  componentWillMount: function() {
    return this.intervals = [];
  },
  setInterval: function() {
    return this.intervals.push(setInterval.apply(null, arguments));
  },
  componentWillUnmount: function() {
    return this.intervals.map(clearInterval);
  }
};

module.exports = SetIntervalMixin;
