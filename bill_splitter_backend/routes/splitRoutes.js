const express = require('express');
const router = express.Router();
const Split = require('../models/Split');

// POST /api/splits/create
router.post('/create', async (req, res) => {
  try {
    const { groupName, people, amounts, selectedIndices, transactions } = req.body;

    const newSplit = new Split({
      groupName,
      people,
      amounts,
      selectedIndices,
      transactions,
      createdAt: new Date()
    });

    await newSplit.save();

    res.status(201).json({ message: 'Split saved successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to save split' });
  }
});

module.exports = router;
