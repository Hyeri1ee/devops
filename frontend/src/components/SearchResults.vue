<template>
    <v-table>
    <thead>
    <tr>
        <th class="text-left">
        Teacher code
        </th>
        <th class="text-left">
        Fullname
        </th>
        <th class="text-left">
        Email
        </th>
    </tr>
    </thead>
    <tbody>
    <tr
        v-for="item in results"
        :key="item.fullname"
    >
        <td>{{ item.shortname }}</td>
        <td>{{ item.fullname }}</td>
        <td>{{ item.email }}</td>
    </tr>
    </tbody>
    </v-table>
</template>

<script>
export default {
    props: ['results']
}
</script>
