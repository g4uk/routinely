import React from 'react';
import Routine from 'components/Routine';

export default function RoutinesList({ routines }) {
  return (
    <table className="table">
      <thead>
        <tr>
          <th>Name</th>
          <th>Sensors</th>
          <th>Users</th>
          <th></th>
        </tr>
      </thead>
      {routines.map(routine =>
        <Routine key={routine.id} {...routine} />
      )}
    </table>
  );
}

RoutinesList.propTypes = {
  routines: React.PropTypes.array.isRequired,
};
